require 'pry'
require 'rmagick'
include Magick

# Assign rows count
rows = (1..6)
images_to_merge = []

# Push all images-to-merge path to array
rows.each do |folder|
  images_to_merge << Dir["images/#{folder}/*"]
end

final_image = ImageList.new

# Dynamically create variables for each rows
rows.each { |i| eval("@row_#{i} = ImageList.new") }

# Assign images from folders into relative row variable
images_to_merge.each_with_index do |images, index|
  index += 1
  #[60..images.length]
  images[0..59].each { |image| eval("@row_#{index}").push(Image.read(image).first.resize_to_fit!(137, 137)) }
end

# Union all rows into one
rows.each { |i| final_image.push(eval("@row_#{i}").append(false)) }

final_image.append(true).write('output.png')
