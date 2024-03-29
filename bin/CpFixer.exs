# Código feito por ArthurSpeziali
# https://github.com/ArthurSpeziali

IO.puts("\e[2J\e[H")

IO.puts("Seja Bem-Vindo ao CpFixer! (Re-imaginação do CpfDescovery, escrito em Python)")
IO.puts("By: Arthur Speziali\n")
Process.sleep(1_000)

IO.puts("Atenção! Talvez o programa consuma bastande o CPU se minerar mais de 2.000 CPFs!")
Process.sleep(2_000)

IO.puts("\e[2J\e[H")

IO.puts("Digite se deseja validar, minerar ou completar um Cpf: [V/M/C]\n")
response = App.Menus.main(["v", "m", "c"])

case response do
    "v" -> App.Menus.cpf_validate()
    "m" -> IO.puts("M")
    "c" -> IO.puts("C")
end
