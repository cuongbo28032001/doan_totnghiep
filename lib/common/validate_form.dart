class ValidateForm {
  String? validateText(String? value) {
    if (value!.isEmpty) {
      return 'Tên không được để trống!';
    } else if (!RegExp(
            r'^[a-z A-Z ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳýỵỷỹ]+$')
        .hasMatch(value)) {
      return 'Tên không được chứa chữ số hay ký tự đặc biệt!';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email không được bỏ trống";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Email không đúng định dạng abc@def.xyz !';
    } else {
      return null;
    }
  }

  String? validateNumber(String? value) {
    if (value!.isEmpty) {
      return 'Số điện thoại không được để trống!';
    } else if (!RegExp(r'(84|0[3|5|7|8|9])+([0-9]{8})\b').hasMatch(value)) {
      return 'Số điện thoại không đúng!';
    } else {
      return null;
    }
  }

  String? validateUserName(String? value) {
    if (value!.isEmpty) {
      return 'Tên không được để trống!';
    } else if (!RegExp(r'^[a-zA-Z0-9\+]*$').hasMatch(value)) {
      return 'Tên đăng nhập không được chứa ký tự đặc biệt!';
    } else {
      return null;
    }
  }

  String? validatePass(String? value) {
    if (value!.isEmpty || value == '') {
      return 'Mật khẩu không được để trống!';
    } else if (value.length < 6) {
      return "Mật khẩu phải có 6 ký tự trở lên!";
    } else {
      return null;
    }
  }

  String? validateNewPass(String? value) {
    if (value!.isEmpty || value == '') {
      return 'Mật khẩu không được để trống!';
    } else if (value.length < 6) {
      return "Mật khẩu phải có 6 ký tự trở lên!";
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$')
        .hasMatch(value)) {
      return "Mật khẩu phải có ít nhất 1 chữ hoa, 1 chữ thường và 1 số";
    } else {
      return null;
    }
  }

  String? validateCurentPass(String? value, String? curentValue) {
    if (curentValue!.isEmpty) {
      return "Mật khẩu không được để trống!";
    } else {
      if (curentValue.compareTo(value!) == 0) {
        return '';
      }
      return "Mật khẩu xác nhận không đúng!";
    }
  }
}
