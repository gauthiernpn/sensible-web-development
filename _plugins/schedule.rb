module Jekyll
  class ScheduleTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
    	toc = []
      @site = context.registers[:site]

      output = []
      @site.config['chapter_groups'].each do |i, c|
      	intro = c[0].data
        next if intro['layout'] != 'intro'
        output << "<h2><a href='#{c[0].url}'>Week #{intro['index']}</a> – <small>#{intro['date']}</small></h2>"
        output << "<h3>Assignments Due</h3>#{md(intro['due'])}"
        output << "<h3>Reading Due</h3>#{md(intro['reading'])}"
        output << "<h3>Workshop Topic</h3>#{md(intro['workshop'])}"
        output << "<h3>Lab Assigned</h3>#{md(intro['assignment']['title'])}"
      end
      output.join('');
    end

    def md(string)
      converter = @site.getConverterImpl(::Jekyll::Converters::Markdown)
      converter.convert(string)
    end
  end
end

Liquid::Template.register_tag('schedule', Jekyll::ScheduleTag)

