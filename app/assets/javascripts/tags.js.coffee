jQuery(document).ready ->
  cloud = document.getElementById('tagcloud')
  tags = cloud.getElementsByTagName('a')
  i = 0
  while i < tags.length
    tag = tags[i]
    weight = tag.getAttribute('data-weight')
    size =  weight / 10 + 1
    size = 1 if size < 1
    size = 2 if size > 2
    tag.style.fontSize = size + 'em'
    i++
