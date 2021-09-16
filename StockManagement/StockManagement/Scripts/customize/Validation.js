// 檢查字串長度
function validateTxtWidth(txt, min = 1, max = 999) {
    if (txt.length < min)
        return { isValid: false, msg: '長度最少要' + min + '個字元!', code: 'minError' };
    if (txt.length > max)
        return { isValid: false, msg: '長度最多只能' + max + '個字元!', code: 'maxError' };
    return { isValid: true };
}

// 檢查字串內容
function validateTxtContext(txt, alphabet = true, number = true, others = false) {
    if (alphabet && number && !others) {
        let result = txt.match(/[^0-9a-z]/);
        if (result != undefined)
            return { isValid: false, msg: '輸入內容必須是A-z或0-9' };
        return { isValid: true };
    } else if (!alphabet && number && !others) {
        let result = txt.match(/[^0-9]/);
        if (result != undefined)
            return { isValid: false, msg: '輸入內容必須是0-9' };
        return { isValid: true };
    }
}

// 檢查Email
function validateEmail(txt) {
    let result = txt.match(/\s/);
    if (result != undefined)
        return { isValid: false, msg: 'Email不可有空格', code: 'WhiteSpaceError' };

    let result2 = txt.match(/^.+@/);
    if (result2 == undefined)
        return { isValid: false, msg: 'Email格式不正確', code: 'ContentError' };
    return { isValid: true };
}

// 檢查日期
function validateDate(txt) {
    if (txt == '')
        return { isValid: false, msg: '請輸入日期' };

    let inputDate = new Date(txt);
    let year = Number(txt.split('-')[0]);
    if (year < 1940 || inputDate >= new Date(Date.now()))
        return { isValid: false, msg: '請輸入合理日期' };
    return { isValid: true };
}

// 檢查是否為空
function validateNullWhiteSpace(txt) {
    if (txt.length < 1)
        return { isValid: false, msg: '輸入欄不可為空', code: 'NullWhiteSpaceError' };
    return { isValid: true };
}

// 更動input的class和提示訊息
function ChangeInvalid(ele) {
    ele.removeClass('myValid').addClass('myInvalid')
        .siblings('.valid-feedback').css('display', 'none')
        .siblings('.invalid-feedback').css('display', 'block')
}
function ChangeValid(ele) {
    ele.addClass('myValid').removeClass('myInvalid')
        .siblings('.invalid-feedback').css('display', 'none')
        .siblings('.valid-feedback').css('display', 'block')
}

// 檢查原宿是否有myValid class
function CheckHasValid(item) {
    return $(item).hasClass('myValid');
}

$(function () {
    $('form').submit(function (event) {
        console.log('sub');

        // Email
        $('input.myValidation.validateEmail[type=text]').on('keyup', function () {
            let result = validateEmail($(this).val());

            if (!result.isValid) {
                $(this).siblings('.invalid-feedback').html(result.msg);
                ChangeInvalid($(this));
            } else {
                ChangeValid($(this));
            }

        }).trigger('keyup');

        // 日期
        $('input.myValidation.validateDate[type=date]').on('change', function () {
            let result = validateDate($(this).val());

            if (!result.isValid) {
                $(this).siblings('.invalid-feedback').html(result.msg);
                ChangeInvalid($(this));
            } else {
                ChangeValid($(this));
            }
        }).trigger('change');

        // 是否空值
        $('input.myValidation.validateNullWhiteSpace[type=text]').on('keyup', function () {
            $(this).val($(this).val().trim());
            let result = validateNullWhiteSpace($(this).val());

            if (!result.isValid) {
                $(this).siblings('.invalid-feedback').html(result.msg);
                ChangeInvalid($(this));
            } else {
                ChangeValid($(this));
            }
        }).trigger('keyup');

        // Check所有.myValidation是否通過
        if (!$('input.myValidation').toArray().every(CheckHasValid)) {
            event.preventDefault()
            event.stopPropagation()
        }
    });
});