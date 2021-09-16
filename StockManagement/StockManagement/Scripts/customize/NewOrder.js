// 設定fuse的options
const options = {
    includeScore: true,
    keys: [
        { name: "Name", weight: 0.4 },
        { name: "Artist", weight: 0.4 },
        { name: "Region", weight: 0.1 },
        { name: "Brand", weight: 0.1 }
    ]
}
const fuse = new Fuse(cdObj, options);

// 利用pattern執行Fuzzy Search，並將結果寫入搜尋的Dropdown List中
function fuzzySearch(pattern) {
    let result = fuse.search(pattern);

    $("#dropdownSearch").html("");

    var count = 0;
    for (re of result) {
        if (count++ >= 10)
            break;
        $("#dropdownSearch").append('<li><a class="dropdown-item" href="javascript:void(0)" onclick="dropitemClick(this)" data-refIndex="' + re.refIndex + '">' + re.item.Name + '</a></li>');
    }
    return result;
}

// 搜尋的Dropdown List項目被點選時
function dropitemClick(ele) {
    // 取得被點選的List的內容(專輯名稱)並寫入搜尋textbox(自動完成)，並執行一次FuzzySearch改寫下拉選單內容
    $(".txtSearchClass").val($(ele).html());

    var result = fuzzySearch($(".txtSearchClass").val());
    for (var re of result) {
        if (re.item.Name == $(ele).html()) {
            result = new Array();
            result.push(re);
            break;
        }
    }
    $("#ContentPlaceHolder1_HFSearchResult").val(JSON.stringify(result));

    // 避免被Form Validate擋掉
    if ($(".txtSellerClass").val() == "")
        $(".txtSellerClass").val(" ");

    $('form').submit();
}

// 將TempList裡的東西轉換成物件陣列回傳
function GetTempList() {
    let list = $("#TempListContainer").children("li");
    let listObj = new Array();
    for (var item of list) {
        let spans = $(item).children(".text-div").children("span");
        let name = $(spans[0]).html();
        let q = $(spans[1]).html();
        listObj.push({
            Name: name,
            Quantity: q
        });
    }
    return listObj;
}

// 寫入TempList
function RenderTempList(list) {
    $("#TempListContainer").html("");
    for (let r of list) {
        $("#TempListContainer").append('\
                    <li class="list-group-item d-flex justify-content-between list-group-item-action list-group-item-cus">\
                        <div class="text-div d-flex justify-content-between" >\
                            <span>' + r.Name + '</span>\
                            <span class="badge bg-primary rounded-pill">' + r.Quantity + '</span>\
                        </div>\
                        <div class="QuaPopup">\
                            <button type="button" class="btn-close btn QuaPopup-closebtn" aria-label="Close"></button>\
                                數量<br>\
                            <input type="number" name="quantity" min="1" max="999" value="' + r.Quantity + '" onkeydown="return event.key != \'Enter\';">\
                        </div>\
                        <button type="button" class="btn btn-outline-primary btnTempListDel">刪除</button>\
                    </li>');
    }
}

// 結果列表細目的新增按鈕檢查一遍是否要disabled
function CheckAddButton() {
    let names = new Array();
    for (let tempItem of GetTempList()) {
        names.push(tempItem.Name);
    }
    let IDs = new Array();
    for (let obj of cdObj) {
        if (names.indexOf(obj.Name) != -1)
            IDs.push(obj.SerialCode);
    }
    let buttons = $("#search_list_tab_content > div.tab-pane > button");
    for (let item of buttons) {
        if (IDs.indexOf($(item).attr("id").slice(5)) == -1) {
            $(item).prop("disabled", false).addClass("btn-outline-success").removeClass("btn-outline-danger")
                .removeAttr("data-bs-toggle")
                .removeAttr("data-bs-placement")
                .removeAttr("title");
        }
        else {
            $(item).prop("disabled", true).addClass("btn-outline-danger").removeClass("btn-outline-success")
                .attr({
                    "data-bs-toggle": "tooltip",
                    "data-bs-placement": "bottom",
                    "title": "Tooltip on bottom"
                });
        }
    }
}

// 搜尋鈕被按下時，將搜尋結果轉成JSON格式放入HiddenField回傳至後台
function btnSearchClick() {
    var result = fuzzySearch($(".txtSearchClass").val());
    $("#ContentPlaceHolder1_HFSearchResult").val(JSON.stringify(result));

    // 避免被Form Validate擋掉
    if ($(".txtSellerClass").val() == "")
        $(".txtSellerClass").val(" ");
}

// 新增到暫存列表按鈕
function btnAddTemp(btn) {
    var id = $(btn).attr("id").slice(5);

    // 到cdObj陣列裡找相對應id的CD，如果找到就利用Ajax跟後台交換資料
    for (let item of cdObj) {
        if (item.SerialCode == id) {
            $(btn).prop("disabled", true).removeClass("btn-outline-success").addClass("btn-outline-danger")
                .attr({
                    "data-bs-toggle": "tooltip",
                    "data-bs-placement": "bottom",
                    "title": "Tooltip on bottom"
                });
            //.tooltip("show");

            let url = "/SystemBackEnd/Handler/CDDataHandler.ashx?Action=NewOrderTempList";
            let tempListJSON = JSON.stringify(GetTempList());
            let addCDObj = {
                Name: item.Name,
                Quantity: 1
            };
            let addCDJSON = JSON.stringify(addCDObj);

            $.ajax({
                url: url,
                type: "POST",
                data: {
                    TempListType: "Add",
                    TempListJSON: tempListJSON,
                    AddCD: addCDJSON
                },
                success: function (result) {

                    // 將交換來的資料重新寫入TempList
                    RenderTempList(result);

                    // 新寫入的元素重新綁定事件
                    TempListBind();
                }
            });
            break;
        }
    }
    if (!$(btn).prop("disabled"))
        console.log("Error: Can't find the CD.");
}

// 變更暫存數量時呼叫，利用Ajax跟後台資料交換
function ChangeQuantity(name, quantity) {
    let url = "/SystemBackEnd/Handler/CDDataHandler.ashx?Action=NewOrderTempList";
    let tempListJSON = JSON.stringify(GetTempList());
    let changeCDObj = {
        Name: name,
        Quantity: quantity
    };
    let changeCDJSON = JSON.stringify(changeCDObj);

    $.ajax({
        url: url,
        type: "POST",
        data: {
            TempListType: "ChangeQuantity",
            TempListJSON: tempListJSON,
            ChangeCD: changeCDJSON
        },
        success: function (result) {

            // 將交換來的資料重新寫入TempList
            RenderTempList(result);

            // 新寫入的元素重新綁定事件
            TempListBind();
        }
    });
}

// 刪除暫存的項目
function DeleteTempItem(name, quantity) {
    let url = "/SystemBackEnd/Handler/CDDataHandler.ashx?Action=NewOrderTempList";
    let tempListJSON = JSON.stringify(GetTempList());
    let deleteCDObj = {
        Name: name,
        Quantity: quantity
    };
    let deleteCDJSON = JSON.stringify(deleteCDObj);

    $.ajax({
        url: url,
        type: "POST",
        data: {
            TempListType: "Delete",
            TempListJSON: tempListJSON,
            DeleteCD: deleteCDJSON
        },
        success: function (result) {
            // 將交換來的資料重新寫入TempList
            RenderTempList(result);

            // 新寫入的元素重新綁定事件
            TempListBind();

            // 所有新增按鈕檢查一遍是否要disabled
            CheckAddButton();
        }
    });
}

// TempList綁定事件的function
function TempListBind() {

    // Popup和刪除紐的位置
    $('.QuaPopup').css("bottom", function (index, val) {
        let cal = -($(this).height() - $(this).parent().height()) / 2
        if (index == 0)
            return cal - 15;
        return cal;
    });
    $(".btnTempListDel").css("bottom", function (index, va) {
        let cal = -($(this).height() - $(this).parent().height()) / 2
        if (index == 0)
            return cal - 15;
        return cal;
    });

    // Popup的關閉紐
    $('.QuaPopup-closebtn').on('click', function () {
        $(this).removeClass("myClosebtnShow")
            .parent().removeClass("myShow")
            .siblings(".btnTempListDel").removeClass("myShow")
            .parent().removeClass('myActive');

        // 判斷數量是否被改變，如改變，呼叫ChangeQuantity()
        var spans = $(this).parent().siblings(".text-div").children("span");
        var badgeNum = $(spans[1]).html();
        var inputNum = $(this).siblings("input[name='quantity']").val();

        if (badgeNum != inputNum)
            ChangeQuantity($(spans[0]).html(), inputNum);
    });

    // Popup本身
    $('.QuaPopup').bind({
        mouseenter: function () {
            hStatus = 1;
            $(this).children(".QuaPopup-closebtn").addClass("myClosebtnShow");
        },
        mouseleave: function () {
            hStatus = 0;
            $(this).children(".QuaPopup-closebtn").removeClass("myClosebtnShow");
        },
        focusout: function () {
            if (hStatus == 0) {
                $(this).removeClass("myShow")
                    .siblings(".btnTempListDel").removeClass("myShow")
                    .parent().removeClass("myActive");

                // 判斷數量是否被改變，如改變，呼叫ChangeQuantity()
                var spans = $(this).siblings(".text-div").children("span");
                var badgeNum = $(spans[1]).html();
                var inputNum = $(this).children("input[name='quantity']").val();

                if (badgeNum != inputNum)
                    ChangeQuantity($(spans[0]).html(), inputNum);
            }
        },
        click: function () {
            $(this).children("input[name='quantity']").focus();
        }
    });

    // 數量輸入欄檢查
    $("input[name='quantity']").change(function () {
        var num = Number($(this).val());
        if (num <= 0)
            $(this).val("1")
        else if (num > 999)
            $(this).val("999")
        else if (!Number.isInteger(num))
            $(this).val(Math.floor(num))
    });

    // TempList刪除紐
    $(".btnTempListDel").bind({
        mouseenter: function () {
            hStatus = 1;
            $(this).siblings(".QuaPopup").children(".QuaPopup-closebtn").addClass("myClosebtnShow");
        },
        mouseleave: function () {
            hStatus = 0;
            $(this).siblings(".QuaPopup").children(".QuaPopup-closebtn").removeClass("myClosebtnShow");
        },
        click: function () {
            let spans = $(this).siblings(".text-div").children("span");
            DeleteTempItem($(spans[0]).html(), $(spans[1]).html());
        }
    });
}

// After body loaded.
$(function () {
    let shouldValidate = true;


    originalSearchVal = $(".txtSearchClass").val();
    fuzzySearch(originalSearchVal);

    // 搜尋textbox註冊keyup事件
    $(".txtSearchClass").on({
        keyup: function () {
            fuzzySearch($(".txtSearchClass").val());
        }
    });

    if ($(".txtSellerClass").val() == " ")
        $(".txtSellerClass").val("");

    // Submit時檢查Seller必須為1-50
    $('form').submit(function (event) {
        $('input[id$=Seller]').on('keyup', function () {
            //if (!shouldValidate) {
            //    $('input.myValidation').addClass('myValid');
            //    return;
            //}

            $(this).val($(this).val().trim());
            let result = validateTxtWidth($(this).val(), 1, max = 50);

            if (!result.isValid) {
                if(result.code == 'minError')
                    $(this).siblings('.invalid-feedback').html('請輸入賣家');
                else
                    $(this).siblings('.invalid-feedback').html(result.msg);
                ChangeInvalid($(this));
            } else {
                ChangeValid($(this));
            }

        }).trigger('keyup');

    })

    // 取消紐事件
    $("input[id$=btnCancel]").click(function () {
        // 避免被Form Validate擋掉
        $('input.myValidation').addClass('myValid');
    })
    

    // 建立紐事件
    $("input[id$=btnSave]").click(function () {
        var LIs = $("#TempListContainer").children("li");
        if (LIs.length == 0) {
            submitStatus = false;
            return;
        }
        var result = fuzzySearch(originalSearchVal);
        $("#ContentPlaceHolder1_HFSearchResult").val(JSON.stringify(result));
    })

    // 暫存列表Container註冊事件(子節點觸發)
    $('#TempListContainer').on('click', '.list-group-item > div.text-div', function () {
        $(this).parent().addClass('myActive').siblings().removeClass('myActive');
        $(this).siblings(".btnTempListDel").addClass("myShow")
            .siblings(".QuaPopup").addClass("myShow")
            .children("input[name='quantity']").focus();
        $(this).parent().siblings().children(".QuaPopup").removeClass("myShow")
            .siblings(".btnTempListDel").removeClass("myShow");
    });

    // 查看暫存列表Hidden Field是否為空，有值就將它Render進暫存列表
    let tempListStr = $("#ContentPlaceHolder1_HFTempList").val();
    if (tempListStr != "") {
        let HFTempList = JSON.parse(tempListStr);
        RenderTempList(HFTempList);
    }

    // 檢查結果列表裡的新增鈕是否要disabled，然後暫存列表裡的元素綁定事件
    CheckAddButton();
    TempListBind();
});