# DB_MVEcom
Đây là repository chính thức cho môn Hệ cơ sở dữ liệu HK231.

***(Cập nhật đầu tiên 12/1/2023): Cập nhật hệ thống đăng nhập đăng ký, sử dụng cơ chế tokenization***

## Document cho project
Link (chỉ đọc): https://www.overleaf.com/read/fkyzmchjqydn#c3e7f6

## Setup ngay sau khi clone project lần đầu
### Setup cơ sở dữ liệu MySQL và khởi chạy server MySQL trên máy
- Các bạn có thể cài trực tiếp ứng dụng MySQL lên máy, hoặc cài đặt ứng dụng tổng hợp XAMPP tại [đây](https://www.apachefriends.org/download.html). Code được viết để chạy trên XAMPP. 
- Nếu dùng MySQL, thì vào file `connect_db.js` để thay đổi mật khẩu.
- Nếu dùng XAMPP, cài đặt xong thì vui lòng run as administrator ứng dụng, khi cửa sổ bật ra thì bấm nút Start ở dòng MySQL và Apache. Sau đó vào trình duyệt bất kỳ trên máy, nhập localhost rồi enter. Trang Welcome sẽ hiện ra.
- Trên thanh điều hướng, nhấn vào mục `phpMyAdmin`. Trang quản lý sẽ hiện ra, và trên thanh điều hướng mới lúc này sẽ có nút Import hoặc nhập. Bấm vào đó, khi trang hiện lên sẽ thấy khung chọn tệp. Chọn tệp `e_commerce.sql` rồi bấm nhập. Sau khi xong, để ý dashboard bên trái màn hình, cái list với mấy cái icon hình trụ ấy, nếu thấy một dòng tên `e_commerce` xuất hiện nghĩa là file database đã nhập thành công. Có thể nhấp vào dòng đó để bắt đầu xem trong cái database đó có gì.
- Mỗi khi kiểm tra thấy repo có cập nhật, nên drop cái database cũ, rồi import lại file `e_commerce.sql` hiện tại trong project vì có thể có những thay đổi trên DB. Các bạn khi làm xong nếu có đổi gì trong database cũng export file sql mới rồi bỏ vào repo này để người sau còn cập nhật theo.
### Setup các thư viện cho project
Do việc push kèm thư mục node_modules (thư mục chứa các thư viện cho NodeJS và ReactJS) sẽ khiến project trở nên rất nặng (thư mục node_modules của ReactJS có dung lượng loanh quanh 300-400 MB), cũng như git sẽ không thể track được toàn bộ thay đổi.

Do đó, hai thư mục node_modules của NodeJS và ReactJS đã phải được đưa vào .gitignore.

Vì thế, ngay sau khi clone project này về lần đầu tiên, các thành viên vui lòng tiến hành cài đặt lại các thư viện này. Cụ thể như sau:

Với NodeJS, mở terminal và gõ:
```
npm install
```
Các thư viện cần thiết cho NodeJS sẽ được cài đặt.

Với ReactJS cũng tương tự, chỉ cần chuyển vào thư mục views sau đó cài đặt. Gõ hai lệnh sau:
```
cd views
npm install
```
Các thư viện cần thiết cho ReactJS sẽ được cài đặt.

## Khởi chạy web
Sau khi clone project này, mở terminal tại thư mục mà project được clone (nếu đang ở thư mục views thì phải quay ra thư mục cha nha) và gõ:
```
npm run dev
```
Trang localhost:3000 sẽ khởi chạy tự động trên trình duyệt mặc định của máy sau vài giây nếu việc thiết lập thành công (nó hơi lâu một chút do phải khởi chạy cả ReactJS ở front-end lẫn NodeJS/ExpressJS ở back-end)

## Một số thông tin về web
### Công nghệ được sử dụng
- Front-end:
    - HTML + CSS
    - Bootstrap 5 (được cài đặt như là một thư viện trong thư mục node_modules của ReactJS)
    - Javascript
    - jQuery
    - ReactJS
    - Axios (để thực hiện http request trong ReactJS)
- Back-end:
    - Server code: NodeJS v20, ExpressJS
    - Database: MySQL
### Kiến thức cần nắm
- React - Arrow function, Hooks (useState, useEffect)
- Axios - Promised based. (https://www.youtube.com/watch?v=_zeOSnVHI2I)
- Route
- github
    - Đầu tiên, ta git clone https://github.com/vandungvo/DB_MVECom.git 
    - Sau đó, khi ta thay đổi code, ta muốn push lên remote repository
        - git add .
        - git commit -m "..."
        - git pull origin master
        - git push origin master.
- Referencial link: https://www.youtube.com/playlist?list=PL_-VfJajZj0W8-gf0g3YCCyFh-pVFMOgy
### Các lưu ý
- File database này hiện chỉ có 1 table là user có dữ liệu. Vui lòng thêm các table khác liên quan đến module mà các bạn làm, cũng như thêm dữ liệu vào khi làm.
- Hiện tại, trang đã hiện thực tính năng đăng nhập (signin/authentication),  đăng ký (signup/registration) và có cơ chế xác thực (authorization), và các thành viên được khuyến khích đọc qua code cả Front-end lẫn Back-end để hiểu và thêm cơ chế xác thực (authorization) vào các trang, các tính năng cần đăng nhập với quyền nhất định (xem minh hoạ trong chính repo này về hai trang công khai (/publicTest) và trang ẩn (/protectedTest) để hiểu và quan sát cách nó vận hành). 
- Lưu ý thêm là mật khẩu của user trong database sẽ bị mã hoá, do đó khi đăng ký bất kỳ user nào mới thì phải nhớ mật khẩu. Mật khẩu cho hai tài khoản đang có sẵn trong database hiện tại là 23571113
- Trang web hiện được viết theo mô hình kết hợp giữa MVC và Layer, trong đó phần UI chứa trong thư mục `views` được xem là một layer chứa tất cả các component liên quan, sử dụng ReactJS để hiện thực. Ngoài ra tồn tại một layer API để React gọi về server NodeJS đối với các tác vụ cần database hoặc xử lý từ server. Ở server NodeJS thì vẫn tổ chức hai bộ phận là Controller và Model.
- Nếu có đổi database về sau, chỉ cần thay đổi file `connect_db` và các file model đối tượng liên quan trong thư mục `model`. Code hiện tại đã cố gắng chia tách phần model kết nối database này với phần model của từng page trong web nhằm đảm bảo khi hiện thực hoặc đổi database, chỉ cần thay đổi kết nối trong `connect_db` và thay đổi các câu lệnh truy vấn trong các file model đối tượng liên quan, còn API mà các file đối tượng cung cấp ra là không đổi và không cần sửa (tuân thủ tối da bộ quy tắc quan trọng trong lập trình: SOLID)
- Trang web có vài thiết lập liên quan đến bảo mật thông qua các thư viện: `helmet`, `express-rate-limit`.
- Sau mỗi thay đổi ở NodeJS server code, vui lòng `Ctrl+C` để tắt cả ReactJS và NodeJS server, sau đó `npm run dev` lại để khởi chạy lại server, thì các thay đổi mới thấy được.

