# Protocolo para uma simulação de Dinâmica Molecular Clássica de um sistema antígeno-anticorpo

**Passo 1 - Obtenção do arquivo PDB**       
  **1.1.** Baixa o arquivo [5ggs_cutted.pdb](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/5ggs_cutted.pdb) e mova para o seu diretorio.       
  **1.2.** Você pode vizualizar a estrutura com o [ChimeraX](https://www.cgl.ucsf.edu/chimerax/download.html), [PyMOL](https://www.pymol.org/), [3DView](https://www.rcsb.org/3d-view), ou [colab](https://colab.research.google.com/drive/1ZR92F636_iWE12LKWWZ8H3XZ1TYKKAU4?usp=sharing)  . Também podes visualizar o conteúdo do arquivo, abrindo-o com um editor de texto simples, como vim/vi (Ubuntu) ou bloco de notas (Windows).      
  

***Passo 2 - Preparação dos arquivos de input***        
  **2.1.** Faz uma cópia de prevenção do seu arquivo              
  `cp 5ggs_cutted.pdb 5GGS.pdb.bk`

  **2.2.** verificar se há resíduos cisteínas formando interações de pontes dissulfeto.      
- Em um arquivo PDB a informação de quais átomos estão envolvidos em interações de pontes dissulfeto encontram-se no final do arquivo, nas linhas que CONECT. No AMBER as cisteínas envolvidas em nessas interações devem ser renomeadas para CYX.
- usa o comando abaixo e verifica essas informações.    
  `tail 5ggs_cutted.pdb`       
- output esperado:             
<img width="609" height="151" alt="image" src="https://github.com/user-attachments/assets/87e62dd6-3293-41ca-80d2-722fa5a62362" />


**2.3.** Limpar o arquivo PDB   
- Depois de visualizar a molécula, você pode remover todos os átomos que não pertencem às proteínas do teu sistema (por exemplo, moléculas de água cristalina, ligantes, etc.). Para excluir esses átomos (rotulados como "HETATM" no arquivo PDB) e, eventualmente, suas conexões, você pode:
usar um editor de texto simples como o vi (Ubuntu), ou Bloco de Notas (Windows), ou você também pode usar o comando ***sed*** para excluir todas as linhas com muita facilidade. 

- Em um arquivo no formato PDB, as linhas que começam com a palavra ***ATOM*** correspondem aos átomos pertencentes aos resíduos de aminoácidos (ou nucleotídeos, no caso de DNA/RNA). As linhas que começam com a palavra ***TER*** indicam término de uma cadeia polipeptídica, e as linhas que começam com a palavra ***END*** indicam o fim do arquivo, geralmente a última linha.

- Para o nosso caso nós temos três cadeias polipeptídica, então devemos manter a linha que especifica o termino de cada uma delas e também manter a linha que determina o final do arquivo.
- Primeiro vamos verificar se o arquivo contém linhas diferentes de ***ATOM, TER e END***,  para isso vamos usar o comando:                         
  `grep -vE '^(ATOM|TER|END)' 5ggs_cutted.pdb`      
- Agora vamos remover essas linhas usando o comando abaixo:    
  `sed -i -e '/^\(ATOM\|TER\|END\)/!d' 5ggs_cutted.pdb`
 - Abre o arquivo com o Vi e verifica se essas linhas foram removidas

***Passo 3 - Determinar os estados de protonação a um dado pH***         
 - Nós estamos tentando simular um sistema biológico real, que nem sempre é representado por um arquivo PDB. Um exemplo disso é o estado de protonação do resíduo de aminoácido histidina, que dependendo das condições de pH do ambiente, este resíduo pode existir na forma neutra (pH alto, HID e HIE) ou protonada (pH baixo, HIP), que diferem em carga e geometria do anel aromático. A forma neutra do anel imidazol aromático pode participar das interações cátion-π com vários cátions metálicos ou resíduos de Lys e Arg. Já na forma protonada, doa interações cátion-π com outros resíduos aromáticos [Phe, Tyr e Trp](https://doi.org/10.1038/s41598-024-51905-y). A dica é: conheça seu sistema e como ele funciona, isso vai ajudar a simular e obter resultados mais próximos da realidade.

<img width="1190" height="307" alt="image" src="https://github.com/user-attachments/assets/aba2e7c7-7fb0-4ad3-809b-1f6382e950bc" />                                

            
- Antes de do cálculo , crie  uma copia de segurança do seu arquivo.      
`cp 5ggs_cutted.pdb 5GGS_clean.pdb`

- Vamos usar o [servidor](https://server.poissonboltzmann.org/pdb2pqr) do programa PDB2QR para fazer esse cálculo, usando o método PROPKA com o valor de ***pH 8***, o mesmo valor usado no experimento da obtenção dessa estrutura reportado no [artigo](https://doi.org/10.1038/ncomms13354). Carrega o arquivo ***5GGS_clean.pdb*** no servidor e selecione as opções igual a figura abaixo e clique em **start job**.
  
<img width="1330" height="854" alt="image" src="https://github.com/user-attachments/assets/e59c0ed8-f0f1-4676-aacd-27565b1c5ae2" />                        

                            
- A página a seguir, é a de resultados.
- Baixa o arquivo no formato PQR, geralmente é o terceiro output se contares de cima para baixo.      
<img width="1835" height="835" alt="image" src="https://github.com/user-attachments/assets/e09039a0-9d29-4820-ae07-ddcf880e4d6d" />    

- Mova esse arquivo para o seu diretorio e renomeie para ***5ggs_pos_pdb2qr.pqr***
- Esse servidor não fornece um arquivo PDB. Use um visualizador como [ChimeraX](https://www.cgl.ucsf.edu/chimerax/download.html) ou [PyMOL](https://www.pymol.org/) para converter para PDB.    
   - No Chimera, vai até ao menu principal, clique em ***FAVORITES** e selecione ***MODEL PANEL***,                        
   - Na caixa de diálogo Model Panel role o menu lateral até baixo e selecione a opção WRITE PDB, dê um nome e salve o arquivo.              
   - Para essa parte do tutorial, esse arquivo já está pronto e o [5ggs_pos_pdb2qr.pdb](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/5ggs_pos_pdb2qr.pdb), baixe e mova para o seu diretório.               
- Esse arquivo terá o nome das CIS alterado para CYX, e os nomes dos resíduos HIS também serão alterados de acordo com o estado de protonação.

***Passo 4 - Remover hidrogênio***   
- Carrega o modulo do amber e usa o comando abaixo:       
  `module load amber/AT19A18`    
  `reduce -Trim 5ggs_pos_pdb2qr.pdb > 5GGS_noHID.pdb`

***Passo 5 - Verificar e deixar o arquivo pronto para o tleap***      
  `pdb4amber 5GGS_noHID.pdb -o 5GGS_noHID_pdb4amber.pdb`      
   - Esse arquivo terá a informação dos CONECTS no final do arquivos
    
***Passo 6 - Neutralizar os terminais***      
 - As proteínas e os peptídeos têm duas extremidades conhecidas como N-terminal no início da cadeia (grupo amino) e C-terminal no final da cadeia (grupo carboxila). Se por algum motivo você clivar/fragmentar a proteína, não é interessante deixar os grupos desses terminais com cargas livres (NH3+ e COO−) pois essas cargas não desejadas podem gerar interações artificiais que não que existe no seu sistema. E para evitar isso, existe o que chamamos de capeamento que é adicionar resíduos especiais para neutralizar esses terminais.
   - Faça uma copia do seu arquivo: `cp 5GGS_noHID_pdb4amber.pdb 5GGS_capeado.pdb`
   - Abra o aquivo ***5GGS_capeado.pdb*** com um editor de texto e edite conforme as instruções abaixo.       
   - O N-terminal é capeado usando o resíduo ACE, um grupo [acetil](https://doi.org/10.1038/s12276-018-0116-z) [−C(= O) − CH3]. O início do seu arquivo deve ficar igual a figura abaixo:         
     <img width="735" height="81" alt="image" src="https://github.com/user-attachments/assets/382d890c-014d-489b-bd0c-628aa7d9c889" />                     

     - Note que o átomo carbono alfa do resíduo é substituído por CH3, e o nome do resíduo do átomo é substituído por ACE. Os átomos de hidrogênios devem ser omitidos, eles serão automaticamente adicionados se o nome do resíduo e dos átomos pesamos estiverem corretos.


   - O C-terminal é capeando usando o resíduo NHE (extremidade amidada, NH2) ou NME (N-metilamida, NH −CH3).
     - Para o NHE, o nome do resíduo do átomo N é substituído por NHE.
       <img width="737" height="45" alt="image" src="https://github.com/user-attachments/assets/d5b264b0-9c06-4812-aadc-60fc81cc499d" />                     

          
     - Para o NME, o nome do resíduo dos átomo N e CA são substituídos por NME e CH3, respectivamente.   
       <img width="734" height="56" alt="image" src="https://github.com/user-attachments/assets/0cb86392-f2b6-484f-8f31-3592a79e0a5c" />                            


      
***Passo 7 - Montar o sistema em solvente explícito***     
- As proteínas e ligantes não estão isolados no seu micro-ambiente biológico, as reações biológicas, como a ligação de um ligante ao seu receptor, o enovelamento de proteínas, ocorrem na interface entre uma proteína, o [solvente circundante](10.1529/biophysj.105.058917) juntamente com ions como [Na+, K+ e  Cl-](https://doi.org/10.1021/ct9006579).
- Dessa forma, antes de executar a simulação é necessário colocar o nosso sistema em condições similares. Para isso vamos usar o a ferramenta tleap do amber e executar os seguintes comandos:    

  **7.1.** Campo de força
   - A dinâmica molecular resolve a segunda lei de Newton para todos os átomos de um sistema, usando as forças derivadas do campo de força para prever como eles se movem ao longo do tempo. Conhecer o seu sistema é importante pois determina escolha do campo de força. Para a nossa aula, o nosso tipo de molécula é uma proteína, e é sugerido pelos desenvolvedores do AMBER usar o campo de força ff14SB , em conjunto com o modelo de água tip3p para esse sistema.
       - ***Comece o tleap digitando e informa o campo de força e o tipo de água:***    
       `tleap`     
       `source leaprc.protein.ff14SB`    
       `source leaprc.water.tip3p`
       
       - ***carregar o complexo***     
       `sis=loadpdb 5GGS_capeado.pdb`

       - ***verificar se há choques estéricos entre átomos do sistema***             
       `check sis`     

       - ***Especificar quais cisteínas formam interações de pontes dissulfeto***
       - Renomear a CYS para CYX apenas informa ao LEaP que uma cisteína está envolvida em uma ponte dissulfeto, não quais cisteínas estão ligadas a quais. É isso que definiremos a seguir. O comando de ligação informa ao LEaP que estamos formando uma ligação entre esses dois átomos específicos.             
       `bond sis.24.SG sis.93.SG`             
       `bond sis.138.SG sis.212.SG`                 
       `bond sis.262.SG sis.330.SG`                       

       - ***Neutralizar a carga do sistema***   
       - Neutralizamos a carga do nosso sistema adicionando contra-íons. O comando abaixo vai verificar a carga atual do sistema. Se a carga for por exemplo 6, vamos adicionar 6 átomos de Cl- para balancear a carga.    
       `check sis`
       `addions sis Cl- 6`     
       - verifica novamente se a carga foi zerada
       `check sis`
    
         ***É esperado o resultado zero (0)***
  
       - ***adicionar caixa de água octaédrica***   
       - Vamos solvatar o nosso sistema em solvente explícito. O parâmetro SolvateOct instrui o LEaP a solvatar o arquivo 5GGS_capeado.pdb em uma caixa com formato de octaedro. Esse formato imita uma esfera e é um formato de caixa muito comum. O número indica ao LEaP o tamanho da caixa. Aqui, cada parte da proteína estará a pelo menos 10,0 Å da borda da nossa caixa preenchida com água. Geralmente, são necessárias pelo menos três camadas de solvatação em todos os lados da superfície da proteína para uma simulação de dinâmica molecular, e 10,0 Å garantem isso.
       `solvateoct sis TIP3PBOX 10.0` 

       - ***Adição de concentração salina***     
       - No passo anterior, nós apenas neutralizamos a carga do sistema, para melhor mimetizar as condições biológicas das proteínas precisamos também adicionar [150 mM de NaCl](http://dx.doi.org/10.1016/B978-0-12-411604-7.00002-7). Isso exigirá a adição de pares de íons Na+ e Cl-, com base no volume da caixa.    
     
       - Para esse calculo vamos usar o servidor [SLTCAP](https://www.phys.ksu.edu/personal/schmit/SLTCAP/SLTCAP.html),
         - Duas informações serão necessárias para esse cálculo:
           
          **(i)** massa do complexo proteico
          Para obtermos esse valor, vamos usar este [servidor](https://web.expasy.org/compute_pi/). Nele será necessário introduzir a sequência de aminoácidos do complexo inteiro. Essa informação você encontra [aqui](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/sequencia-complexo.txt)
            - O resultado esperado deve ser similar a figura abaixo:
            <img width="536" height="466" alt="image" src="https://github.com/user-attachments/assets/a16a145c-7bf4-428a-b083-dd3c44ca976a" />

            Vamos usar o valor de Mw(peso Molecular)   

          **(ii)** número de moléculas de água
            Essa informação você acha na última linha de output do comando de inserir a caixa de água. Essa linha começa com a palavra *added*    
            <img width="718" height="197" alt="image" src="https://github.com/user-attachments/assets/7b0b4739-09dc-4132-b7cc-d8bafff390c8" />                                   

       - Preecha esses valores no servidor dd, deve parecer igual a figura abaixo
            <img width="427" height="387" alt="image" src="https://github.com/user-attachments/assets/ee2fb68c-59ca-45b5-b356-b6342fd021a2" />                                           
        - Clique em **Calculate** e anota o resultado, que deve ser similar a figura abaixo                                               
            <img width="294" height="121" alt="image" src="https://github.com/user-attachments/assets/3e04b717-95b4-44b8-8bc2-7156c9b71b3a" />                                             
   
       - Use o comando abaixo no tLeap para adicionar a quantidade de íons de forma aleatória no sistema.    
       `addionsRand sis Na+ 54 Cl- 54`
 
       - ***Salvar os arquivos de topologia (prmtop) e de coordenadas (rst7)***        
       `saveamberparm sis 5GGS_capeado_solvated.prmtop 5GGS_capeado_solvated.rst7`                     

***Passo 8 - Relaxação do sistema***    
  - A relaxação será dividida em quatro etapas.            
        **(i)** - Nessa [primeira etapa](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/min1.in) vamos relaxar o solvente e os íons e todo o soluto vai ser fixo por uma força de restrição harmônica de 500 kcal.mol-1.     
        - Quando adicionamos as águas não levamos em consideração que elas podem fazer sobreposição com as proteína do sistema. Da mesma forma os íons, nós somente adicionamos ao sistema de forma aleatória, sem considerar a posição de outras moléculas presentes. Algumas moléculas de água podem estar muito próximas dos átomos do soluto, gerando repulsões e/ou colisões.  Essa primeira minimização remove más interações iniciais (como sobreposições e repulsões) no solvente, relaxando o ambiente ao redor do soluto. Assim, só as moléculas de água e íons podem se mover livremente e ajustar suas posições.
    
    **(ii)** - Na [segunda etapa](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/min2.in), uma segunda minimização é feita considerando todo o sistema livre, buscando um estado de menor energia global.
              
    **(iii)** - Na [terceira etapa](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/heat.in), o sistema é submetido a um aquecimento linear (para evitar que átomos sofram acelerações súbitas e colidam) da temperatura, de 0 a 310K durante 100 ps, com uma restrição harmônica de 10 kcal.mol-1 sobre os átomos de soluto, utilizando ensemble NVT. O sistema ganha movimento aos poucos, pois é atribuido aos átomos velocidades aleatórias.

    **(iv)** - Na [quarta etapa](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/dens.in), vamos subtemer o sistema a uma equilibração da densidade, utilizando um ensemble NPT, utilizando termostato de Langevin com frequência de choque igual a 2 e barostato Monte Carlo para manterem temperatura e pressão respectivamente a 310 K e 1 atm, durante 500 ps, com a mesma restrição sobre os átomos do soluto. Estamos permitindo que a caixa varie seu volume naturalmente até atingir a densidade correta (por exemplo: remover o excesso de espaços vazios na caixa de água).
    
    **(v)** - E por fim, a [equilibração](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/equ.in) final é feita sem qualquer restrição de movimentação de átomos por 5 ns. São mantidos os parâmetros da etapa de equilibração de densidade, exceto pela restrição dos átomos.


    - Para este tutorial será apenas necessário fazer algumas alterações para adequar os script da simulação ao seu sistema:  
        - Nos arquivos [min1.in](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/min1.in), [min2.in](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/min2.in), [heat.in](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/heat.in), [dens.in](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/dens.in) e [equ,in](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/equ.in) altere o parametro/flag ``restraintmask=':'`` insere o número total de resíduos qdo seu sistema. Por exemplo, se no total (proteína + anticorpo), o teu sistema tem 352 reśiduos, você deve preencher da seguinte maneira: ``restraintmask=':1-352'``. Esse valor corresponde exatamente ao número de resíduos de sistema usado nesta prática.     
  
    - Para executar o relaxamento; execute os seguintes comandos na ordem abaixo!
      
       ```     
        pmemd.cuda -O -i min1.in  -p 5GGS_capeado_solvated.prmtop -o min1.out -c 5GGS_capeado_solvated.rst7 -x min1.nc -r min1.rst  -ref 5GGS_capeado_solvated.rst7                     
        pmemd.cuda -O -i min2.in  -p 5GGS_capeado_solvated.prmtop -o min2.out -c min1.rst -r min2.rst -ref min1.rst              
        pmemd.cuda -O -i heat.in  -p 5GGS_capeado_solvated.prmtop -o heat.out -c min2.rst -r heat.rst -x heat.nc -ref min2.rst             
        pmemd.cuda -O -i dens.in  -p 5GGS_capeado_solvated.prmtop -o dens.out -c heat.rst -r dens.rst -x dens.nc -ref heat.rst                 
        pmemd.cuda -O -i equ.in   -p 5GGS_capeado_solvated.prmtop -o equ.out  -c dens.rst -r equ.rst  -x equ.nc  -ref dens.rst                                
       ```
       
***Passo 8 - Produção da dinâmica molecular***    
  - A etapa de produção da dinâmica ocorre em uma produção de 30 ns a 310 K, com todo sistema solto, sem restrições.       
  - Para executar a relaxação execute os seguintes comandos na ordem abaixo, usando o arquivo [mdPROD.in](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/mdPROD.in)!      
       ``pmemd.cuda -O -i mdPROD.in -p 5GGS_capeado_solvated.prmtop -o mdProd1.out -c equ.rst -r mdProd1.rst -x mdProd1.nc``

- Você pode colocar tudo em um [script único](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/run_MD/script_unico.sh) e rodar o comando:     
``bash script_unico.sh &``      


***Passo 9 - Análise dos resultados***         
  **9.1. Calcular o RMSD da interface de ligação usando o cpptraj**        
  - Neste turorial, nós definimos como resíduos da interface de ligação todos aqueles resíduos da proteína cujo seu atómo carbono alfa está a 8Å de distância do atómo carbono alfa de qualquer resíduos do anticorpo.
  - Para esse cálculo serão necessários todos os arquivos de trajetoria resultantes da simulação e o arquivo de topologia de input.

  Crie um arquivo **analise.in** e escreve nele o seguinte:
   > Carregue os arquivos de topologia e os de trajetoria de input
 
   ```    
   parm 5GGS_capeado_solvated.prmtop    
   reference 5GGS_capeado_solvated.rst7     
   ```
 
   > Carrega os arquivos de trajetoria da simulação      
   `trajin mdProd1.nc`
        
   > Recentraliza as moléculas conforme as imagens periódicas            
   `autoimage`         
     
   > Calcular o RMSD                     
   `rmsd 1-113<:8.0&:114-352@CA|:114-352<:8.0&:1-113@CA first :1-113<:8.0&:114-352@CA|:114-352<:8.0&:1-113@CA out rsmd-5ggs.dat`
  
   > Calcular interações de ligação de Hidrogênio            
   `hbond :1-352 out interface_hbonds.dat avgout agv_interface_hbonds.dat nointramol`

- No final o seu arquivo deve se parecer com isso:           
```    
parm 5GGS_capeado_solvated.prmtop           
reference 5GGS_capeado_solvated.rst7              
            
trajin mdProd1.nc                  
autoimage                                            

rmsd 1-113<:8.0&:114-352@CA|:114-352<:8.0&:1-113@CA first :1-113<:8.0&:114-352@CA|:114-352<:8.0&:1-113@CA out rsmd-5ggs.dat                      
hbond :1-352 out interface_hbonds.dat avgout agv_interface_hbonds.dat nointramol                            
               
run              
```

- Após ter o seu script pronto, você pode rodar os cálculos usando o comando abaixo:     
`cpptraj -i analise.in`

- É esperado serem gerados os seguintes arquivos de saída [agv_interface_hbonds.dat](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/outputs_esperados/agv_interface_hbonds.dat), [rsmd-5ggs.dat](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/outputs_esperados/rsmd-5ggs.dat), [interface_hbonds.dat](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/outputs_esperados/interface_hbonds.dat)   
    
### A análises dos arquivos de saída serão feitas nesse [colab](https://colab.research.google.com/drive/1ZR92F636_iWE12LKWWZ8H3XZ1TYKKAU4?usp=sharing)  
  
  

