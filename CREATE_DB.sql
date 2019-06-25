CREATE DATABASE SPONGE;
CREATE TABLE Dataset(
dataset_ID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
disease_name varchar(0,255),
data_origin varchar(0,255),
disease_type varchar(0,255),
download_url varchar(0,255)
);
CREATE TABLE Run(
run_ID int NOT NULL AUTO_INCREMENT,
dataset_ID int NOT NULL,
variance_cutoff int,
gene_expr_file varchar(0,255),
miRNA_expr_file varchar(0,255),
f_test boolean,
f_test_p_adj_threshold decimal,
coefficient_threshold decimal,
coefficient_direction varchar(0,255),
parallel_chunks_step1 int,
min_corr decimal,
parallel_chunks_step2 int,
number_of_datasets int,
number_of_samples int,
ks varchar(0,255),
m_max int,
log_level varchar(0,255),
PRIMARY KEY(run_ID),
FOREIGN KEY(dataset_ID) REFERENCES Dataset(dataset_ID)
);
CREATE TABLE Target_databases (
td_ID int NOT NULL, AUTO_INCREMENT,
run_ID int NOT NULL,
database varchar(0,255),
version varchar(0,255),
url varchar(0,255)
PRIMARY KEY(td_ID),
FOREIGN KEY(run_ID) REFERENCES Run(run_ID)
);
CREATE TABLE Gene(
gene_ID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
description varchar(0,255),
gene_symbol varchar(0,255),
ensg_number varchar(0,255),
chromosome_name varchar(0,255),
start_pos int,
end_pos int,
gene_type varchar(0,255)
);
CREATE TABLE Expression_data_gene(
expr_ID int NOT NULL AUTO_INCREMENT,
run_ID int NOT NULL,
gene_ID int NOT NULL,
exp_value decimal,
sample_ID varchar(0,255),
PRIMARY KEY(expr_ID),
FOREIGN KEY(run_ID) REFERENCES Run(run_ID),
FOREIGN KEY(gene_ID) REFERENCES Gene(gene_ID)
);
CREATE TABLE Selected_genes(
selected_genes_ID int NOT NULL AUTO_INCREMENT,
run_ID int NOT NULL,
gene_ID int NOT NULL,
PRIMARY KEY(selected_genes_ID),
FOREIGN KEY(run_ID) REFERENCES Run(run_ID)
FOREIGN KEY(gene_ID) REFERENCES Gene(gene_ID)
);
CREATE TABLE miRNA(
miRNA_ID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
id_type varchar(0,255),
mir_ID varchar(0,255),
seq varchar(0,999),
hs_nr varchar(0,255)
);
CREATE TABLE Expression_data_miRNA(
expr_ID int NOT NULL AUTO_INCREMENT,
run_ID int NOT NULL,
miRNA_ID int NOT NULL,
expr_value decimal,
sample_ID varchar(0,255),
PRIMARY KEY(expr_ID),
FOREIGN KEY(run_ID) REFERENCES Run(run_ID),
FOREIGN KEY(miRNA_ID) REFERENCES MiRNA(miRNA_ID)
);
CREATE TABLE Interactions_genegene(
interactions_genegene_ID int NOT NULL AUTO_INCREMENT,
run_ID int NOT NULL,
gene_ID1 int NOT NULL,
gene_ID2 int NOT NULL,
p_value decimal,
mscore decimal,
correlation decimal,
PRIMARY KEY(interactions_genegene_ID),
FOREIGN KEY(run_ID) REFERENCES Run(run_ID),
FOREIGN KEY(gene_ID1) REFERENCES Gene(gene_ID),
FOREIGN KEY(gene_ID2) REFERENCES Gene(gene_ID);
);
CREATE TABLE Interacting_miRNAs(
interacting_miRNAs_ID int NOT NULL AUTO_INCREMENT,
interactions_genegene_ID int NOT NULL,
miRNA_ID int NOT NULL,
PRIMARY KEY(interacting_miRNAs_ID),
FOREIGN KEY(interactions_genegene_ID) REFERENCES Interactions_genegene(interactions_genegene_ID),
FOREIGN KEY(miRNA_ID) REFERENCES MiRNA(miRNA_ID)
);
CREATE TABLE Survival_rate(
survival_ID int NOT NULL AUTO_INCREMENT,
gene_ID int NOT NULL,
dataset_ID int NOT NULL,
time_of_survival int,
probability decimal,
PRIMARY KEY(survival_ID),
FOREIGN KEY(gene_ID) REFERENCES Gene(gene_ID),
FOREIGN KEY(dataset_ID) REFERENCES Dataset(dataset_ID)
);
CREATE TABLE Network_analysis(
network_analysis_ID int NOT NULL AUTO_INCREMENT,
gene_ID int NOT NULL,
run_ID int NOT NULL,
eigenvektor decimal,
betweeness decimal,
node_degree decimal,
PRIMARY KEY(network_analysis_ID),
FOREIGN KEY(gene_ID) REFERENCES Gene(gene_ID),
FOREIGN KEY(run_ID) REFERENCES Run(run_ID)
);

