data {
  int <lower = 0>N;       // Número de observaciones
  int <lower = 0>k;       // Número de covariables 
  vector[N] y;            // Variables respuesta
  matrix [N,k] X;         // Variables de efecto fijo regresoras
  // efecto aleatorio 
  int <lower = 0>kz; 
  matrix [N,kz] Z;        // Variables de efecto aleatroio
}

parameters {
  vector[k] beta;         // Coeficientes del modelo
  vector[kz] gamma;           // Efecto aleatroio
  real <lower = 0> sigma2;
  
}

transformed parameters{
 vector[N] lp;
 real<lower=0> sigma;
 sigma = sqrt(sigma2);
 lp =  X*beta + Z * gamma;
}

model {
  beta ~ normal(0,1000);
  gamma ~ normal(0,1000);
  sigma2 ~ inv_gamma(0.0001, 0.0001);
  y ~ normal(lp , sigma);
}

generated quantities {
    real ypred[N];                    // Vector de longitud n
    vector [N]lppred; 
    lppred =  X*beta + Z * gamma;
    ypred =  normal_rng(lppred , sigma);
}
