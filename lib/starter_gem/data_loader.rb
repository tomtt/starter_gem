require 'open-uri'
require 'gist'
require 'digest'

module StarterGem
  class LinesNotFoundError < IOError; end

  class DataLoader
    class << self
      def raw_to_lines(raw)
        raw.split("\n")
      end

      def read(src, fallback_dir: "data_files")
        raw_to_lines read_url_or_file(src, fallback_dir: fallback_dir)
      end

      def digest_for_source(src, fallback_dir: "data_files")
        Digest::SHA256.hexdigest read_url_or_file(src, fallback_dir: fallback_dir)
      end

      private

      def read_file(src, fallback_dir:)
        File.read(filename_with_fallback_dir(src, fallback_dir: fallback_dir))
      rescue Errno::ENOENT
        raise(LinesNotFoundError, "Unable to open file source for lines '#{src}'")
      rescue Errno::EISDIR
        raise(LinesNotFoundError, "Source file for lines is a directory '#{src}")
      end

      def filename_with_fallback_dir(filename, fallback_dir:)
        if File.exist?(filename)
          filename
        else
          StarterGem.root.join(fallback_dir, filename)
        end
      end

      def ensure_is_not_html!(raw)
        return unless raw =~ /<html>|<p>/

        raise(LinesNotFoundError, "Url source contains html, not lines '#{url}'")
      end

      def read_raw_url(url)
        if url =~ /gist\.github\.com/
          Gist.read(url)
        else
          URI.parse(url).open.read
        end
      rescue OpenURI::HTTPError, SocketError
        raise(LinesNotFoundError, "Url source for lines not found '#{url}")
      end

      def read_url(url)
        raw = read_raw_url(url)
        ensure_is_not_html!(raw)
        raw
      end

      def read_url_or_file(src, fallback_dir:)
        if src.to_s =~ /^https?:/
          read_url(src)
        else
          read_file(src, fallback_dir: fallback_dir)
        end
      end
    end
  end
end
