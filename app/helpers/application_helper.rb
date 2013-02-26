module ApplicationHelper
  # 改行コードをBRタグに変更する
  def convertBR(target)
    target = html_escape(target)
    target.gsub(/\r\n|\r|\n/, "<br />")
  end
end
