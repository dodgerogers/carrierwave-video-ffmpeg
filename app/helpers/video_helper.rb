module VideoHelper
  def sublime_video(video)
    video_tag([video.file], id: "video_#{video.id}", class: "sublime", size: "748x374", data: { name: video.file, uid: video.id, autoresize: "fit" }, preload: "none")
  end
  
  def display_screenshot(video)
    video.screenshot.present? ? video.screenshot : "placeholder.jpg"
  end
end
