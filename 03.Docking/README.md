<img width="1500" height="844" alt="image" src="https://github.com/user-attachments/assets/386faa22-12e5-4993-ad57-332c70293443" />


# Predição de interações

Este conjunto de etapas foca na predição do sítio de ligação do anticorpo (parátopo) e do seu alvo (epítopo), culminando na modelagem da estrutura do complexo (anticorpo-alvo) através de ancoragem molecular (docking).

1. Utilize o [Parasurf](https://huggingface.co/spaces/angepapa/ParaSurf) para prever os resíduos do anticorpo (Pembrolizumabe) que interagem com o antígeno (PD-1). Filtrar e selecionar os resíduos com pontuação de parátopo (paratope score) igual ou superior a 0.5 usando um Notebook [Colab](https://colab.research.google.com/drive/1GLWdmNNblMR6jfrydyR56pu2sXYf2Mhb?usp=sharing).

2. Utilize o [ElliPro](http://tools.iedb.org/ellipro/) para prever as regiões de superfície do antígeno (PD-1) que são prováveis de serem reconhecidas pelo anticorpo.

3. Ajuste e Padronização do PDB: Corrigir as inserções e a numeração do PDB utilizando as ferramentas [PDB-Tools](https://rascar.science.uu.nl/pdbtools/submit).

4. Ajuste do Estado de Protonação: Ajustar o estado de protonação das proteínas para um pH fisiológico de 7.4 (ou o pH de interesse para o estudo) usando o software [PDB2PQR](https://server.poissonboltzmann.org/pdb2pqr).

5. Executar o docking proteína-proteína com o [ClusPro](https://cluspro.org/home.php), utilizando o modo Antibody Mode (Modo Anticorpo) para aproveitar as informações específicas de anticorpos e melhorar a precisão da predição.  

6. Predição da Estrutura do Complexo: Realizar a predição estrutural do complexo (Fv-PD-1) usando o [Protenix](https://protenix-server.com/model/prediction/add).

7. Realizar a predição de interações usando o servidor [RING 4.0](https://ring.biocomputingup.it/)
