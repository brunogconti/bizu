import Typed from 'typed.js';

// const list = document.getElementById("thisThing");
// var courses = $('#thisThing').data('url');
// console.log(list);

// const list2 = document.querySelectorAll("#thisThing ul");
//   list2.forEach((item) => {
//     console.log(item.innerText);
//   });



const loadDynamicBannerText = () => {
  const list = [ 'Ciências Biológicas: Biofísica ',
  'Ciências Biológicas',
  'Enfermagem e Obstetrícia',
  'Farmácia',
  'Nutrição',
  'Química',
  'Abi - Letras - Português - Árabe',
  'Abi - Letras - Português - Francês',
  'Abi - Letras - Português - Hebraico',
  'Abi - Letras - Português - Italiano',
  'Abi - Letras - Português - Latim',
  'Abi - Letras - Português - Russo',
  'Abi - Literaturas de Língua Portuguesa',
  'Ciência da Computação',
  'Ciências Biológicas',
  'Ciências Biológicas',
  'Ciências Biológicas: Microbiologia e Imunologia',
  'Ciências Matemáticas e da Terra',
  'Dança',
  'Educação Artística - Desenho',
  'Educação Artística Com Habilitação em Artes Plásticas',
  'Educação Física',
  'Enfermagem e Obstetrícia',
  'Engenharia Civil',
  'Engenharia de Bioprocessos',
  'Engenharia de Controle e Automação',
  'Engenharia de Petróleo',
  'Engenharia de Produção',
  'Engenharia Eletrônica e de Computação',
  'Engenharia Metalúrgica',
  'Engenharia Nuclear',
  'Engenharia Química',
  'Estatística',
  'Farmácia',
  'Física',
  'Medicina',
  'Fisioterapia']
  if (document.getElementById("banner-typed-text")) {
    new Typed('#banner-typed-text', {
      strings: list,
      typeSpeed: 80,
      loop: true
    });
  }
}

export { loadDynamicBannerText };
