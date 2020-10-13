clear;

[P,T]=generar_training_vector();
net = newrb(P,T,0.01,5,300);