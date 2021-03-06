#Include "Protheus.ch"

/*/{Protheus.doc} CONSULBD
Exemplo de manipulação de Banco de Dados via AdvPL
@author RAFAEL CUSTODIO
@since 13/05/2017
@version 1.0
	@example
	U_CONSULBD
/*/

User Function CONSULBD()
	Local aArea		:= GetArea()
	Local aAreaB1		:= SB1->(GetArea())
	Local cMens		:= ""
	
	//Verifica se a tabela ja está aberta.
	If Select("SB1") > 0
		MsgStop("<b>Tabela SB1 Ja está aberta!!</b>", "Atenção")
	EndIf
	
	//dbSelectArea: seleciona a tabela SB1 (tabela de produtos)
	DbSelectArea("SB1")
	SB1->(DbSetOrder(1)) // B1_FILIAL+B1_COD: Este é o indice 1 da tabela
	SB1->(DbGoTop())
	
	//Posicionando em um produto específico da tabela (05)
	If SB1->(DbSeek(FWxFilial("SB1") + "05"))
		msgInfo(SB1->B1_DESC)
	EndIf
	
	//Agora, percorro todos os registros e adiciono a descrição em uma variável
	SB1->(DbGoTop())
	While !SB1->(EoF())
		cMens += Alltrim(SB1->B1_DESC)+";"+Chr(13)+Chr(10)
	
		SB1->(DbSkip())
	EndDo
	
	//Mostrando a mensagem
	Aviso('Atenção', cMens, {'OK'}, 03)
	
	RestArea(aAreaB1)
	RestArea(aArea)
Return
