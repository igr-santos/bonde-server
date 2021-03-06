class AggActivist < ActiveRecord::Base
  acts_as_copy_target
  default_scope { order(total_form_entries: :desc) }
  self.table_name = 'public.agg_activists'

  belongs_to :community
  belongs_to :activist

  def readonly?
    true
  end
end
