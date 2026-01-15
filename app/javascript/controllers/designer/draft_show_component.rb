class Designer::DraftShowComponent < ViewComponent::Base

  def initialize(draft:)
    @draft = draft
  end

  private

  def file_size_human
    helpers.number_to_human_size(@draft.try(:file_size) || 0)
  end

  def format_time(time)
    time&.strftime("%Y-%m-%d %H:%M:%S")
  end
end
