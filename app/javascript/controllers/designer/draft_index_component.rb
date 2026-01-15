# frozen_string_literal: true

class Designer::DraftIndexComponent < ViewComponent::Base

  def initialize(drafts:, pagy:, params: {})
    @drafts = drafts
    @pagy = pagy
    @params = params || {} # 防护 nil
  end

  private

  def format_time(draft)
    (draft.upload_time || draft.created_at).strftime("%Y-%m-%d %H:%M")
  end
end