classdef Input

  properties
    num_lgts
    n1
    n2
    d
    W
    lamda
  end
  
  methods
    function obj = Input(num_lgts_in, n1_in, n2_in, d_in, W_in, lamda_in)
      obj.num_lgts = num_lgts_in
      obj.n1 = n1_in
      obj.n2 = n2_in
      obj.d = d_in
      obj.W = W_in
      obj.lamda = lamda_in
    end
  end
end

