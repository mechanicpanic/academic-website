module Jekyll
  class ObsidianWikilinksGenerator < Generator
    safe true
    priority :highest
    
    def generate(site)
      # Process all pages
      site.pages.each do |page|
        if page.ext == ".md"
          page.content = process_wikilinks(page.content, site)
          process_frontmatter_wikilinks(page)
        end
      end

      # Process all documents in collections
      site.collections.each do |name, collection|
        collection.docs.each do |doc|
          if doc.extname == ".md"
            doc.content = process_wikilinks(doc.content, site)
            process_frontmatter_wikilinks(doc)
          end
        end
      end

      # Process posts if they exist
      if site.posts
        site.posts.docs.each do |post|
          post.content = process_wikilinks(post.content, site)
          process_frontmatter_wikilinks(post)
        end
      end
    end
    
    private
    
    def process_wikilinks(content, site)
      # Pattern matches [[Link]] or [[Link|Display Text]]
      content.gsub(/\[\[([^\]|]+)(?:\|([^\]]+))?\]\]/) do |match|
        link_text = $1.strip
        display_text = $2&.strip || link_text
        
        # Try to find the page URL
        url = find_page_url(link_text, site)
        
        # Return as markdown link
        "[#{display_text}](#{url})"
      end
    end
    
    def find_page_url(title, site)
      # Clean the title for URL matching
      slug = title.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-|-$/, '')
      
      # Search in pages
      page = site.pages.find do |p|
        p.data['title'] == title || 
        p.data['title']&.downcase == title.downcase ||
        p.basename.downcase == slug ||
        p.basename.downcase == title.downcase.gsub(/\s+/, '-')
      end
      
      return page.url if page
      
      # Search in all collections
      site.collections.each do |name, collection|
        doc = collection.docs.find do |d|
          d.data['title'] == title || 
          d.data['title']&.downcase == title.downcase ||
          d.basename.downcase == slug
        end
        
        return doc.url if doc
      end
      
      # Special cases for common pages
      case title.downcase
      when "home"
        "/"
      when "publications"
        "/publications/"
      when "research"
        "/research/"
      when "curriculum vitae", "cv"
        "/cv/"
      when "talks & presentations", "talks"
        "/talks/"
      when "teaching"
        "/teaching/"
      when "contact"
        "/contact/"
      when "latex examples"
        "/latex-examples/"
      else
        # Default: convert to URL-friendly format
        "/#{slug}/"
      end
    end

    def process_frontmatter_wikilinks(page)
      # Fields that commonly contain file or page links
      link_fields = ['slides', 'pdf', 'video', 'code', 'website', 'image', 'photo', 'file']

      link_fields.each do |field|
        if page.data[field].is_a?(String) && page.data[field].include?('[[')
          page.data[field] = page.data[field].gsub(/\[\[([^\]|]+)(?:\|([^\]]+))?\]\]/) do |match|
            link_path = $1.strip

            # Handle relative paths from Obsidian (like ../assets/slides/file.pdf)
            if link_path.match?(/\.(pdf|png|jpg|jpeg|gif|svg|mp4|pptx?|docx?|zip)$/i)
              # It's a file link - convert to absolute path
              if link_path.start_with?('../')
                # Remove ../ and assume it's relative to vault root
                link_path = link_path.sub('../', '/vault/')
              elsif link_path.start_with?('/')
                # Already absolute
                link_path
              else
                # Assume it's in vault/assets/
                "/vault/assets/#{link_path}"
              end
            else
              # It's a page link - just remove the wikilink syntax
              link_path
            end
          end
        end
      end
    end
  end
end