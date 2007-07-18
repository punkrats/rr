require "examples/example_helper"

module RR
module Extensions
  describe InstanceMethods, "#mock" do
    it_should_behave_like "RR::Extensions::InstanceMethods"

    before do
      @subject = Object.new
    end

    it "sets up the RR mock call chain" do
      should_create_mock_call_chain mock(@subject)
    end

    it "sets up the RR mock call chain with rr_mock" do
      should_create_mock_call_chain rr_mock(@subject)
    end

    def should_create_mock_call_chain(creator)
      class << @subject
        def foobar(*args)
          :original_value
        end
      end

      scenario = creator.foobar(1, 2) {:baz}
      scenario.times_matcher.should == TimesCalledMatchers::IntegerMatcher.new(1)
      scenario.argument_expectation.class.should == RR::Expectations::ArgumentEqualityExpectation
      scenario.argument_expectation.expected_arguments.should == [1, 2]

      @subject.foobar(1, 2).should == :baz
    end
  end

  describe InstanceMethods, "#stub" do
    it_should_behave_like "RR::Extensions::InstanceMethods"

    before do
      @subject = Object.new
    end

    it "sets up the RR stub call chain" do
      should_create_stub_call_chain stub(@subject)
    end

    it "sets up the RR stub call chain with rr_stub" do
      should_create_stub_call_chain rr_stub(@subject)
    end

    def should_create_stub_call_chain(creator)
      class << @subject
        def foobar(*args)
          :original_value
        end
      end

      scenario = creator.foobar(1, 2) {:baz}
      scenario.times_matcher.should == TimesCalledMatchers::AnyTimesMatcher.new
      scenario.argument_expectation.class.should == RR::Expectations::ArgumentEqualityExpectation
      @subject.foobar(1, 2).should == :baz
    end
  end

  describe InstanceMethods, "#probe and #mock_probe" do
    it_should_behave_like "RR::Extensions::InstanceMethods"

    before do
      @subject = Object.new
    end

    it "sets up the RR probe call chain" do
      should_create_mock_probe_call_chain probe(@subject)
    end

    it "sets up the RR probe call chain" do
      should_create_mock_probe_call_chain mock_probe(@subject)
    end

    it "sets up the RR probe call chain with rr_probe" do
      should_create_mock_probe_call_chain rr_mock_probe(@subject)
    end

    def should_create_mock_probe_call_chain(creator)
      class << @subject
        def foobar(*args)
          :original_value
        end
      end

      scenario = creator.foobar(1, 2)
      scenario.times_matcher.should == TimesCalledMatchers::IntegerMatcher.new(1)
      scenario.argument_expectation.class.should == RR::Expectations::ArgumentEqualityExpectation
      scenario.argument_expectation.expected_arguments.should == [1, 2]

      @subject.foobar(1, 2).should == :original_value
    end
  end

  describe InstanceMethods, "#stub_probe" do
    it_should_behave_like "RR::Extensions::InstanceMethods"

    before do
      @subject = Object.new
    end

    it "sets up the RR probe call chain" do
      should_create_stub_probe_call_chain stub_probe(@subject)
    end

    it "sets up the RR probe call chain" do
      should_create_stub_probe_call_chain rr_stub_probe(@subject)
    end

    def should_create_stub_probe_call_chain(creator)
      class << @subject
        def foobar(*args)
          :original_value
        end
      end

      scenario = creator.foobar
      scenario.times_matcher.should == TimesCalledMatchers::AnyTimesMatcher.new
      scenario.argument_expectation.class.should == RR::Expectations::AnyArgumentExpectation

      @subject.foobar(:something).should == :original_value
    end
  end

  describe InstanceMethods, "#do_not_allow" do
    it_should_behave_like "RR::Extensions::InstanceMethods"
    
    before do
      @subject = Object.new
    end

    it "sets up the RR do_not_allow call chain" do
      should_create_do_not_allow_call_chain do_not_allow(@subject)
    end

    it "sets up the RR do_not_allow call chain with rr_do_not_allow" do
      should_create_do_not_allow_call_chain rr_do_not_allow(@subject)
    end

    it "sets up the RR do_not_allow call chain" do
      should_create_do_not_allow_call_chain dont_allow(@subject)
    end

    it "sets up the RR do_not_allow call chain with rr_do_not_allow" do
      should_create_do_not_allow_call_chain rr_dont_allow(@subject)
    end

    def should_create_do_not_allow_call_chain(creator)
      class << @subject
        def foobar(*args)
          :original_value
        end
      end

      scenario = creator.foobar(1, 2)
      scenario.times_matcher.should == TimesCalledMatchers::IntegerMatcher.new(0)
      scenario.argument_expectation.class.should == RR::Expectations::ArgumentEqualityExpectation
      scenario.argument_expectation.expected_arguments.should == [1, 2]
    end
  end
end
end