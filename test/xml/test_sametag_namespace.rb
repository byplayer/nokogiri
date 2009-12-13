require File.expand_path(File.join(File.dirname(__FILE__), '..', "helper"))

module Nokogiri
  module XML
    class TestSametagNamespace < Nokogiri::TestCase
      def setup
        super
        @xml_doc = Nokogiri::XML <<-eoxml
                <test>
                  <header:Header xmlns:header="http://api.rakuten.co.jp/rws/rest/Header">
                    <value>abc</value>
                  </header:Header>
                </test>
              eoxml
        @xml_ns = {}
        @xml_doc.traverse { |d| @xml_ns.merge! d.namespaces }
      end

      def test_namespaces
        assert_equal('http://api.rakuten.co.jp/rws/rest/Header',
                     @xml_ns['xmlns:header'])
      end

      def test_xpath
        assert_equal('abc', @xml_doc.xpath('/test/header:Header/value',
                                           @xml_ns)[0].content)
      end
    end
  end
end
