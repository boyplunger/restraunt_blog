module ApplicationHelper
  def alert_name(key)
    {
      "notice" => "info",
      "alert"  => "danger"
    }.with_indifferent_access[key] || key
  end

  def heart_icon(blog)
    suffix = blog.has_favorites?(current_user) ? "s" : "r"
    content_tag :i, "", class: "fa#{suffix} fa-heart"
  end

  def avator_tag(resource)
    img_tag(resource, image: 'no_avatar.jpg', class: 'avator')
  end

  def img_tag(resource, **opts)
    if resource.image?
      image_tag(resource.image.thumb.url, class: opts[:class])
    else
      image_pack_tag(opts[:image] || 'no_image.png', class: opts[:class])
    end
  end

  def follow_button(user)
    label, key = current_user.following?(user) ? [tl(:unfollow), "secondary"] : [tl(:follow), "primary"]
    link_to(label, user_follow_path(@user), method: :post, remote: true, class: "btn btn-#{key} btn-sm")
  end

  def tl(key, model_name = controller.controller_name.singularize)
    actions = t("views.actions").keys
    if key.to_sym.in?(actions)
      t("views.actions.#{key}")
    else
      t("activerecord.attributes.#{model_name}.#{key}")
    end
  end

  def tags_for_options
    t("views.tags").invert
  end

  def tags(key = nil)
    t("views.tags.#{key}")
  end
end
