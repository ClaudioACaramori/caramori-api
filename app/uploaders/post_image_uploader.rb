class PostImageUploader < BaseUploader
  version :small do
    process resize_to_fit: [120, 120]
  end

  version :medium do
    process resize_to_fit: [480, 292]
  end

  version :large do
    process resize_to_fit: [800, 600]
  end
end
