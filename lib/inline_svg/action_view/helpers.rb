require 'action_view/helpers' if defined?(Rails)
require 'action_view/context' if defined?(Rails)

module InlineSvg
  module ActionView
    module Helpers
      def inline_svg(filename, transform_params={})
        html = begin
          svg_file = if InlineSvg::IOResource === filename
            InlineSvg::IOResource.read filename
          else
            InlineSvg::AssetFile.named filename
          end

          InlineSvg::TransformPipeline.generate_html_from(svg_file, transform_params)
        rescue InlineSvg::AssetFile::FileNotFound
          "<svg><!-- SVG file not found: '#{filename}' --></svg>"
        end

        if defined?(Rails)
          html.html_safe
        else
          html
        end
      end
    end
  end
end
