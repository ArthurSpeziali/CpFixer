defmodule AppTest do
    use ExUnit.Case, async: true
    setup do
        %{cpf_num: 117_795_906_28, cpf_list: [1,1,7,7,9,5,9,0,6]}
    end

    test "Testando CPF é válido", %{cpf_list: cpf} do

        assert App.Cpf_Tools.validate(cpf, 10) == [2, 8]
    end
    
end
