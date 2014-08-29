module MroongaIndex
  def mroonga_index(table_name, column_name, options = {})
    index_type = if options[:parser].present?
      MYSQL_INDEX_FULLTEXT
    end
    index_sql = %|CREATE #{index_type} INDEX index_#{table_name}_on_#{column_name} ON #{table_name}(#{column_name})|
    index_sql = mroonga_fulltext_index(index_sql, options) if index_type == MYSQL_INDEX_FULLTEXT

    execute index_sql
  end

  private
    MYSQL_INDEX_FULLTEXT = "FULLTEXT"

    def index_comment?
      @mysql_version = `mysql --version` rescue nil
      @mysql_version =~ /Distrib ([\d\.]+?),/
      major, minor, patch = $1.to_s.split(".")
      5 <= major.to_i and 5 <= minor.to_i
    end

    def mroonga_fulltext_index(index_sql, options)
      raise <<-ERROR unless index_comment?
  mysql version needs to be 5.5 and later
  #{@mysql_version || "mysql not installed"}
      ERROR

      parsers = %w[TokenBigram
                   TokenMecab
                   TokenBigramSplitSymbol
                   TokenBigramSplitSymbolAlpha
                   TokenBigramSplitSymbolAlphaDigit
                   TokenBigramIgnoreBlank
                   TokenBigramIgnoreBlankSplitSymbol
                   TokenBigramIgnoreBlankSplitSymbolAlpha
                   TokenBigramIgnoreBlankSplitSymbolAlphaDigit
                   TokenDelimit
                   TokenDelimitNull
                   TokenUnigram
                   TokenTrigram]
      raise "parser not defined" unless parsers.include?(options.fetch(:parser){nil})

      parser = options.fetch(:parser)
      %|#{index_sql} COMMENT 'parser "#{parser}"'|
    end
end

module ActiveRecord
  class Migration
    include MroongaIndex
  end
end
