class SocialprovidersController < ApplicationController
  before_filter :authenticate_user!, except: [:create]

  def index
    @providers_suggested = providers_all = ['persona', 'facebook', 'google', 'twitter']
    @providers_user = current_user.socialproviders.all

    @providers_user.each do | socialprovider |
      @providers_suggested.delete(socialprovider.provider)
    end
  end

  def create
    provider = params[:socialprovider]
    omniauth = request.env['omniauth.auth']

    if omniauth
      # MOZILLA PERSONA
      if provider == 'persona'
        display_name = email = uid = omniauth['uid']
      # FACEBOOK
      elsif provider == 'facebook'
        display_name = omniauth['extra']['raw_info']['name']
        email = omniauth['extra']['raw_info']['email']
        uid = omniauth['extra']['raw_info']['id']
      # GOOGLE OPENID
      elsif provider == 'google'
        display_name = omniauth['info']['name']
        email = omniauth['info']['email']
        uid = omniauth['uid']
      # TWITTER
      elsif provider == 'twitter'
        display_name = omniauth['info']['name']
        email = omniauth['uid'] + '@peppermind.com'
        uid = omniauth['uid']
      end

      #  provider and uid ARE valid
      if provider != '' and uid != ''
        # user is NOT signed in
        if !user_signed_in?
          auth = Socialprovider.where(provider: provider, uid: uid).first
          # user HAS already signed in with this social provider -> sign in
          if auth
            flash[:notice] = 'Erfolgreich via ' + provider.capitalize + ' angemeldet.'
            sign_in_and_redirect :user, auth.user
          # user has NOT already signed in with this social provider
          else
            existinguser = User.where(email: email).first
            # user HAS already a peppermind account -> add social provider to account and sign in
            if existinguser
              existinguser.socialproviders.create provider: provider, uid: uid, display_name: display_name, email: email
              flash[:notice] = 'Anmeldung via ' + provider.capitalize + ' wurde zum Benutzerkonto ' + existinguser.email + ' hinzugefuegt. Anmeldung erfolgreich'
              sign_in_and_redirect :user, existinguser
            # user has NOT already a peppermind account -> create a peppermind account, add the social provider and sign in
            else
              user = User.create email: email, password: SecureRandom.hex(10), display_name: display_name
              user.socialproviders.create provider: provider, uid: uid, display_name: display_name, email: email

              flash[:myinfo] = 'Das Benutzerkonto wurde erfolgreich via ' + provider.capitalize + ' erstellt.'
              sign_in_and_redirect :user, user
            end
          end
        # user IS signed in
        else
          auth = Socialprovider.where(provider: provider, uid: uid).first
          # social prodider IS already linked with this account
          if auth
            flash[:notice] = provider.capitalize + ' ist bereits mit dem Benutzerkonto verknuepft.'
            redirect_to socialproviders_path
          # social provider is NOT already linked with this account -> add social provider to account
          else
            current_user.socialproviders.create provider: provider, uid: uid, display_name: display_name, email: email
            flash[:notice] = 'Anmeldung via ' + provider.capitalize + ' wurde zum Benutzerkonto hinzugefuegt.'
            redirect_to socialproviders_path
          end
        end
      # provider or uid is NOT valid
      else
        flash[:error] =  provider.capitalize + ' schickte ungueltige Daten fuer diese User-ID zurueck.'
        redirect_to new_user_session_path
      end
    # no valid data in request.env['omniauth.auth']
    else
      flash[:error] = 'Fehler bei der Anmeldung via ' + provider.capitalize + '.'
      redirect_to new_user_session_path
    end
  end

  def destroy
    @socialprovider = current_user.socialproviders.find(params[:id])
    @socialprovider.destroy

    redirect_to socialproviders_path
  end
end
