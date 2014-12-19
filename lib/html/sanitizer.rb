require "html/sanitizer/version"
require "loofah"
require "html/sanitizer/scrubbers"
require "html/sanitizer/sanitizer"

module Html
  class Sanitizer
    class << self
      def full_sanitizer
        Html::FullSanitizer
      end

      def link_sanitizer
        Html::LinkSanitizer
      end

      def white_list_sanitizer
        Html::WhiteListSanitizer
      end
    end
  end
end
