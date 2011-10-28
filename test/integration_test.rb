require 'helper'

describe "Ruml binary" do
  it "fails with TypeError w/o arguments" do
    output = exec_ruml nil, nil
    output.must_match "can't convert nil into String (TypeError)"
  end

  it "fails with invalid list path" do
    output = exec_ruml "invalid path", nil
    output.must_match "Couldn't find mailing list in \"invalid path\" (ArgumentError)"
  end
end
