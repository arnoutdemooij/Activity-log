module ApplicationHelper
  def flash_messages
    [:notice, :success, :info, :error].collect do |key|
      style = key
      style = :success if key == :notice
      render 'elements/flash', { :message => flash[key], :style => style } unless flash[key].blank?
    end.join
  end
end
