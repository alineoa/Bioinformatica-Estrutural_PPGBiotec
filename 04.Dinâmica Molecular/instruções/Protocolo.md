# :memo: Protocolo para uma simulação de Dinâmica Molecular Clássica de um sistema proteína-Anticorpo

**Passo 1 - Obtenção do arquivo PDB**       
  **1.1.** Baixa o arquivo [5ggs_cutted.pdb](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/inputs/5ggs_cutted.pdb) e mova para o seu diretorio.
  **1.2.** Você pode vizualizar a estrutura usando o pyMOL ou Chimera. Também podes visualizar o conteúdo do arquivo, abrindo-o com um editor de texto simples, como vim/vi (Ubuntu) ou bloco de notas (Windows).      
  

***Passo 2 - Preparação dos arquivos de input***        
  **2.1.** Faz uma cópia de prevenção do seu arquivo              
  `cp 5ggs_cutted.pdb 5GGS.pdb.bk`

  **2.2.** verificar se há resíduos cisteínas formando interações de pontes dissulfeto.      
- Em um arquivo PDB a informação de quais átomos estão envolvidos em interações de pontes dissulfeto encontram-se no final do arquivo, nas linhas que CONECT. No AMBER as cisteínas envolvidas em nessas interações devem ser renomeadas para CYX.
- usa o comando abaixo e verifica essas informações.    
  `tail 5ggs_cutted.pdb`       
- output esperado:             
![](https://github.com/alineoa/Bioinformatica-Estrutural_PPGBiotec/blob/main/04.Din%C3%A2mica%20Molecular/data/tail%20arquivo.png)

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
 - Nós estamos tentando simular um sistema biológico real, que nem sempre é representado por um arquivo PDB. Um exemplo disso é o estado de protonação do resíduo de aminoácido histidina, que dependendo das condições de pH do ambiente, este resíduo pode existir na forma neutra ou protonada, que diferem em carga e geometria do anel aromático. A forma neutra do anel imidazol aromático pode participar das interações cátion-π com vários cátions metálicos ou resíduos de Lys e Arg. Já na forma protonada, doa interações cátion-π com outros resíduos aromáticos [Phe, Tyr e Trp](https://doi.org/10.1038/s41598-024-51905-y). A dica é: conheça seu sistema e como ele funciona, isso vai ajudar a simular e obter resultados mais próximos da realidade.

   




- Inicialmente é importante que o seu arquivo PDB de entrada contenha apenas as informações necessárias para rodar a simulação. É fortemente sugerido remover as informações desnecessárias mantendo apenas as linhas: ***ATOM, TER e END***
- Se certificar que o ***id cadeias*** estão organizadas na ordem desejada. Neste protocolo, recomendasse que a cadeia do antigeno seja renomeada para ***A***, e movida para o topo (em primeiro) no arquivo PDB. A cadeia pesada do anticorpo seja renomeada para ***H***  e a cadeia leve para ***L***

***-  Calcular o estado de protonação do sistema e renomear os resíduos de acordo com seus estados de protonação***

***-  Verificar se há ligações dissulfeto, renomear a cisteína involvidas nessas ligações e criar o registros SSBOND no arquivo pdb***

***-  Remover os hidrogénios***

***-  Neutralizar as cargas no N-terminal e no C-terminal usando o [script de capeamento desse endereço](https://github.com/SFBBGroup/Notebook_EduardoMenezes/tree/main/Mestrado/simulacao/scripts/capeamento)***

***-  Criar os arquivos de coordenada e topologia usando o tleap do amber***

***-  Fazer o Reparticionamento de massa de hidrogênio (HMR) do sistema do arquivo de topologia através do parmed***  

***2 - Relaxação do sistema***   
  - A relaxação será dividida em quatro etapas. Inicialmente considerando somente as águas e íons livres e todo o soluto fixo por uma força de 500 kcal.mol-1. Após isso, uma segunda minimização é feita considerando todo o sistema livre.  Uma vez feita a minimização, o sistema é submetido a um aquecimento linear da temperatura, de 0 a 310K durante 200 ps, com uma restrição harmônica de 10 kcal.mol-1 sobre os átomos de soluto, utilizando ensemble NVT. Uma etapa de equilibração da densidade das águas é feita, utilizando um ensemble NPT, utilizando termostato de Langevin com frequência de choque igual a 2 e barostato Monte Carlo para manterem temperatura e pressão respectivamente a 310 K e 1 atm, durante 500 ps, com a mesma restrição sobre os átomos do soluto. E por fim, a equilibração final é feita sem qualquer restrição de movimentação de átomos por 5 ns. São mantidos os parâmetros da etapa de equilibração de densidade, exceto pela restrição dos átomos.


***3 - Produção da dinâmica aquecida***   
  - A etapa de produção da dinâmica aquecida ocorre em uma produção de 30 ns a 310 K, seguido de uma de 12,5 ns a 330K, uma de 12,5 ns a 360 K e finalmente uma de 390 K durante 15 ns.

***4 - Calcular o RMSD da interface de ligação usando o cpptraj***   
  - Neste turorial, nós definimos como resíduos da interface de ligação todos aqueles resíduos da proteína cujo seu atómo carbono alfa está a 8Å de distância do atómo carbono alfa de qualquer resíduos do anticorpo.
  - Para esse cálculo serão necessários todos os arquivos de trajetoria resultantes da simulação aquecida e o arquivo de topologia de input.

