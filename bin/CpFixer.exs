# Código feito por ArthurSpeziali
# https://github.com/ArthurSpeziali

# Usa a sequencia Escape, para limpar o terminal e mover o cursor
IO.puts("\e[2J\e[H")

IO.puts("Seja Bem-Vindo ao CpFixer! (Re-imaginação do CpfDescovery, escrito em Python)")
IO.puts("By: Arthur Speziali\n")
# Congela o programa por 1 segundo (1,000 milésimos)
Process.sleep(1_000)

IO.puts("Atenção! Talvez o programa consuma bastande o CPU se minerar mais de 2.000 CPFs!")
Process.sleep(2_000)

IO.puts("\e[2J\e[H")

IO.puts("Digite se deseja validar, minerar ou completar um Cpf: [V/M/C]\n")
# Chamando a função para criar um menu que só aceita estas entradas
response = App.Menus.main(["v", "m", "c"])

case response do
    "v" -> IO.puts("V")
    "m" -> IO.puts("M")
    "c" -> IO.puts("C")
end
