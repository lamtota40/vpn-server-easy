Menambahkan welcome message pada SSH

Login sebagai root
Edit file sshd_config yang terdapat dalam direktori /etc/ssh
Cari baris yang berisi kata  Banner /etc/issue.net. Pastikan bahwa tanda # yang berada dalam awal kata Banner /etc/issue.net sudah dihilangkan
Edit file issue.net yang terdapa dalam direktori /etc dan tambahkan beberapa kalimat welcome message sesuai keinginan anda
Restart service SSH dengan menggunakan perintah /etc/init.d/ssh restart
Login ke Server SSH dan liat apakah Welcome Message udah ganti apa belum
