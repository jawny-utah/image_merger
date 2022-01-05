require 'pry'
images_to_merge = Dir["images/5/*"]

images_to_merge.each_with_index do |images, index|
  File.rename(images, index.to_s.rjust(4, '0') + '.png')
end
