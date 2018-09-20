module TweetsHelper
  def link_class(topic_selected, topic)
    return "" unless topic_selected
    topic_selected == topic ? "text-secondary" : ""
  end
end
