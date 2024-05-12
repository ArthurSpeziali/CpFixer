## Erlang

### No Windows:
#### Baixe e instale o [Executável](https://github.com/erlang/otp/releases/download/OTP-26.2.4/otp_win64_26.2.4.exe) do Erlang.
#### Adicione se necessário o local de instalação do Erlang (C:\Program Files\Erlang OTP\bin\) as váriaveis do sistema

### No Linux:
#### Instale o ASDF
```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo ". $HOME/.asdf/asdf.sh" >> $HOME/.bashrc
echo ". $HOME/.asdf/completions/asdf.bash" >> $HOME/.bashrc
```
#### Adicione o plugin do Erlang
`asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git`
#### Instale o Erlang (Versão recomendada: 24.3)
`asdf install erlang version`
#### Exporte a versão
`asdf global erlang version`


## Elixir

### No Windows:
#### Baixe e instale o [Executável](https://github.com/elixir-lang/elixir/releases/download/v1.16.2/elixir-otp-26.exe) do Elixir.
#### Adicione se necessário o local de instalação do Elixir (C:\Program Files\Elixir\bin\) as váriaveis do sistema

### No Linux:
#### Instale o ASDF
```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo ". $HOME/.asdf/asdf.sh" >> $HOME/.bashrc
echo ". $HOME/.asdf/completions/asdf.bash" >> $HOME/.bashrc
```
#### Adicione o plugin do Elixir
`asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git`
#### Instale o Elixir (Versão recomendada: 1.15.7)
`asdf install elixir version`
#### Exporte a versão
`asdf global elixir version`


## Executável (Escript)

### No Linux:
#### De permisões ao script de instalação na pasta do projeto
`chmod a+x update.sh`

#### Execute o script na pasta do projeto
`./update.sh`

#### Mova para o executavel para o $PATH
`sudo mv $HOME/.cpfixer/app /usr/bin/cpfixer`
