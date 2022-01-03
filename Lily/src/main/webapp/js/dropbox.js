var header = document.querySelector('.header_inner'),
    inner = document.querySelector('.inner');

    inner.addEventListener('mouseover', function(){
        header.style.height = '165px'; 
    });

    inner.addEventListener('mouseover', function(){
        header.style.height = '50px'; 
    });

    /*
    inner에 마우스를 올리면 header 높이가 165로
    나가면 header의 높이를 50으로 변경
    */