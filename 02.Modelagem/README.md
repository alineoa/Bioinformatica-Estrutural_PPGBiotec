<img width="1500" height="844" alt="image" src="https://github.com/user-attachments/assets/5d65f230-e4f9-4d64-8e2e-f1d1e6bca8c3" />

# Modelagem molecular 

1. Pembrolizumabe (Anticorpo): Buscar pelo termo "pembrolizumab" no [Drugbank](https://go.drugbank.com/) e salvar a sequência em formato FASTA.

2. PD-1 (Antígeno): Sugere-se buscar a sequência da proteína Programmed Death-1 em bancos de dados como [UniProt](https://www.uniprot.org/) para obter a sequência para modelagem.

3. Identificação de CDRs: Executar o [ANARCI]((https://opig.stats.ox.ac.uk/webapps/sabdab-sabpred/sabpred/anarci/)) com o esquema de numeração "Martin" para determinar os resíduos correspondentes à região Fv do Pembrolizumabe. Para a identificação correta dos CDRs (Regiões Determinantes de Complementaridade) de acordo com o esquema Martin, consulte a [documentação](http://www.bioinf.org.uk/abs/info.html).

4. Modelagem da Região Fv do Pembrolizumabe pode ser realizada com múltiplas ferramentas, como:

  - [ABodyBuilder2](https://opig.stats.ox.ac.uk/webapps/sabdab-sabpred/sabpred/abodybuilder2/) 
  - [AlphaFold3](https://alphafoldserver.com/)

A estrutura da PD-1 é crucial para estudos da interação alvo-ligante. Pode-se utilizar:

  - [Protein Data Bank](https://www.rcsb.org/)
  - [AlphaFold3](https://alphafoldserver.com/)
  - [AlphaFold Database](https://alphafold.ebi.ac.uk/)
  - [Protenix](https://protenix-server.com/)

5. Validação Estrutural:
   - [MolProbity](https://molprobity.biochem.duke.edu/): clashscore (pontuação de choques estéricos); Ramachandran outliers (resíduos com ângulos de torção incomuns); MolProbity score (pontuação geral de qualidade).
   - [QMEAN](https://swissmodel.expasy.org/qmean/): estimativas de qualidade Global e Local QMEANDisCo.

6. A visualização das estruturas pode ser alcançada com [ChimeraX](https://www.cgl.ucsf.edu/chimerax/download.html), [PyMOL](https://www.pymol.org/), ou [3DView](https://www.rcsb.org/3d-view)


# Análise de propriedades

- [Aggrescan4D](https://biocomp.chem.uw.edu.pl/a4d/)
- [PPStab](https://webs.iiitd.edu.in/raghava/pptstab/index.html)
- [Therapeutic antibody profiler](https://opig.stats.ox.ac.uk/webapps/sabdab-sabpred/sabpred/tap)
- [BioPhi](https://biophi.dichlab.org/)


