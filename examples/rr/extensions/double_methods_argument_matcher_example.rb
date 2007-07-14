require "examples/example_helper"

module RR
module Extensions
  describe DoubleMethods, "#anything" do
    it_should_behave_like "RR::Extensions::DoubleMethods"
    
    it "returns an Anything matcher" do
      anything.should == WildcardMatchers::Anything.new
    end

    it "rr_anything returns an Anything matcher" do
      rr_anything.should == WildcardMatchers::Anything.new
    end
  end

  describe DoubleMethods, "#is_a" do
    it_should_behave_like "RR::Extensions::DoubleMethods"

    it "returns an IsA matcher" do
      is_a(Integer).should == WildcardMatchers::IsA.new(Integer)
    end

    it "rr_is_a returns an IsA matcher" do
      rr_is_a(Integer).should == WildcardMatchers::IsA.new(Integer)
    end
  end

  describe DoubleMethods, "#numeric" do
    it_should_behave_like "RR::Extensions::DoubleMethods"

    it "returns an Numeric matcher" do
      numeric.should == WildcardMatchers::Numeric.new
    end

    it "rr_numeric returns an Numeric matcher" do
      rr_numeric.should == WildcardMatchers::Numeric.new
    end
  end

  describe DoubleMethods, "#boolean" do
    it_should_behave_like "RR::Extensions::DoubleMethods"

    it "returns an Boolean matcher" do
      boolean.should == WildcardMatchers::Boolean.new
    end

    it "rr_boolean returns an Boolean matcher" do
      rr_boolean.should == WildcardMatchers::Boolean.new
    end
  end

  describe DoubleMethods, "#duck_type" do
    it_should_behave_like "RR::Extensions::DoubleMethods"

    it "returns a DuckType matcher" do
      duck_type(:one, :two).should == WildcardMatchers::DuckType.new(:one, :two)
    end

    it "rr_duck_type returns a DuckType matcher" do
      rr_duck_type(:one, :two).should == WildcardMatchers::DuckType.new(:one, :two)
    end
  end
end
end
