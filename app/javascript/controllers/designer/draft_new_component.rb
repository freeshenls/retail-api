class Designer::DraftNewComponent < ViewComponent::Base

  def initialize(draft:)
    @draft = draft
  end

  # 如果有错误信息，可以在这里处理
  def error_messages
    @draft.errors.full_messages
  end
end
