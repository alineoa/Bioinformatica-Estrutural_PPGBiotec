
# :memo: Protocolo para uma simulação de Dinâmica Molecular Clássica de um sistema proteína-Anticorpo

***1- Preparação dos arquivos de input***

***- Limpar o arquivo PDB***
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

