#!/usr/bin/bash
#Idéia:Griff/curs4r
#Criado em Java e recriado em Shell Script por XayUp
#a variável "mn" indica se quando a função "main" for chamada, deverá aparecer o menu (opções/descrições)
mn=1
main() { f='main' #função principal (início)
	if [ "$mn" -ge "1" ]; then
	echo -e "\n###########################
           \n#          Menu           #
           \n#  Selecione a operação   #
           \n###########################
             \n\nX - Definir variáveis de X (ou outro) ou modificar
						 \nY - Definir variáveis de Y (ou outro) ou modificar
             \nC - Criar os pares
						 \nD - Deletar a variavel
             \nS - Sair\n"
	veriXY
	fi
	read -p "> " op
	case $op in
	'x'|'X')
		var='X'
		definir ;;
	'y'|'Y')
		var='Y'
		definir ;;
	'c'|'C')
		pares ;;
		'd'|'D')
		delete ;;
	's'|'S')
		exit ;;
	*[aA-zZ]*|*[0-9]*|'')
		err=$op erro
		main ;;
	esac
}
definir() { #obter os valores de X ou Y definidos pelo usuário
  if [ "$mn" -ge "1" ]; then
	echo -e "\nDigite os valores da variável $var (ou outro):"
	echo E - para salvar e voltar ao menu
	fi
	while [ true ]; do
		read -p "> " op
		case $op in
			'e'|'E')
				mn=1 main ;;
			*[0-9]*)
				if [ $var == "X" ]; then
					x+=($op)
					else
						y+=($op)
				fi ;;
			*[!0-9]*|"")
				err=$op	erro
				mn=0 definir ;;
			esac
	done
	mn=1 main
}
erro() {  #verificar o erro (adicione 'isto contém em $err) e a tarefa se a condição for verdadeiro')
	case $err in
		"") #se vazio
			echo -e "\nNada foi digitado!\n"
			mn=0 ;;
		'0') #se 0
			echo -e "\nA variável X ou Y está vazia!\n"
			mn=0 ;;
		*[aA-zZ]*|*[0-9]*) #se for letra ou número
			echo -e "\nkey \"$op\": Função inválida!\n"
			mn=0 ;;
	esac
}
pares() {  #crie os pares
	if [ ${#x[@]} != '0' -a ${#y[@]} != '0' ]; then
		suss=1
		for ((i=0; i<${#x[@]}; i++)); do
			v=${x[$i]}
				for ((vy=0; vy<${#y[@]}; vy++)); do
					v+=", ${y[$vy]}"
					echo -e "\nPar: ($v)"
					v=${x[$i]}
				done
		done
		echo -e "\nPares criados com sucesso!\n"
		echo -e "Pressione \"F\" para finaliza ou
		       \nPressione \"C\" para voltar ao menu (Com Dados) ou
			   \nPressione qualquer tecla para voltar ao menu (Sem dados)
			   \n e dê Enter"
		read op
		case $op in
			'F'|'f')
				exit ;;
			'C'|'c')
				main ;;
		esac
		x=() #"Vazia"
		y=()
		main
		else
			err=0 erro
			main
	fi
}
delete() { #Griffmod:Deleta os as variaveis criada
echo 'E - para salvar e voltar ao menu'
echo 'T - para deletar todos'
	read -p "Digite a variavel que quer deletar (X,Y):" del
case $del in
	'T'|'t')
	unset x
	unset y;;
	'e'|'E')
	mn=1
	 main ;;
	'X'|'x')
	unset x
	echo -e "a variavel foi deletar";;
	'Y'|'y')
	unset y
	echo -e "a variavel foi deletar";;
	"")
	err=$del erro
	main;;
esac

}
veriXY() { f='main' #printar os valores das váriáveis caso existam valores
  v=""
	if [[ "${#x[@]}" -ne "0" ]]; then
		for ((i=0; i<${#x[@]}; i++)); do
			v+=${x[$i]}
			if [[ $i<$[${#x[@]}-1] ]]; then
				v+=', '
			fi
		done
		echo -e "X:($v) \n"
	fi
	v=""
	if [[ "${#y[@]}" -ne "0" ]]; then
		for ((i=0; i<${#y[@]}; i++)); do
			v+=${y[$i]}
			if [[ $i<$[${#y[@]}-1] ]]; then
				v+=', '
			fi
		done
		echo -e "Y:($v)\n"
	fi
}
main #iniciar a função principal "main()"
