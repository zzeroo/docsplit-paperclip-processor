module Paperclip
 class DocsplitPdf < DocsplitProcessor
    def make
      begin
        dst_dir = Dir.tmpdir
        dst_path = File.join(dst_dir, "#{@basename}.pdf")

        if pdf_format?
          dst_path = File.join(dst_dir, "_#{@basename}.pdf")
          FileUtils.copy_file(src_path, dst_path)
        else
          Docsplit.extract_pdf(src_path, :output => dst_dir)
        end
      rescue Exception => e
        raise Paperclip::Error, "There was an error converting #{@basename} to pdf"
      end
      File.open(dst_path)
    end

    def pdf_format?
      src_path.downcase.include? '.pdf'
    end
  end
end
