require 'testing_env'

class UtilTests < Test::Unit::TestCase

  def test_put_columns_empty
    assert_nothing_raised do
      # Issue #217 put columns with new results fails.
      puts_columns []
    end
  end

  def test_arch_for_command
    # /usr/bin/svn only exists if the command-line tools are installed
    # Skip test on Xcode only systems
    return unless File.exist? '/usr/bin/svn'

    archs = archs_for_command '/usr/bin/svn'
    if `sw_vers -productVersion` =~ /10\.(\d+)/ and $1.to_i >= 9
      assert_equal 1, archs.length
      assert archs.include?(:x86_64)
    elsif `sw_vers -productVersion` =~ /10\.(\d+)/ and $1.to_i >= 7
      assert_equal 2, archs.length
      assert archs.include?(:x86_64)
      assert archs.include?(:i386)
    elsif `sw_vers -productVersion` =~ /10\.(\d+)/ and $1.to_i == 6
      assert_equal 3, archs.length
      assert archs.include?(:x86_64)
      assert archs.include?(:i386)
      assert archs.include?(:ppc7400)
    else
      assert_equal 2, archs.length
      assert archs.include?(:i386)
      assert archs.include?(:ppc7400)
    end
  end

end
