$( function() {
    AddItem("energi_drink", "test", 3, "../../files_client/web/src/img/energi_drink.png", "food" , 5 , 4 , 0,"Red Bull Energy Drink, souvent abrégée en Red Bull, est une boisson énergisante autrichienne créée par Red Bull GmbH ", "#ffdb4d", "thirst" )
    AddItem("banana", "test", 3, "../../files_client/web/src/img/banana.png", "food" , 6 , 7 , 0, "a banane est le fruit ou la baie dérivant de l'inflorescence du bananier. Les bananes sont des fruits très généralement stériles issus de variétés domestiquées.", "#66c2ff", 'food')
    AddItem("chips", "test", 15, "../../files_client/web/src/img/chips.png", "food" , 5 , -8, 0, "Les chips ou pommes chips, connues aussi sous le néologisme de croustilles au Canada, ", "#66c2ff", "food")
    AddItem("firsy_aid_kit", "test", 15, "../../files_client/web/src/img/first_aid_kit.png", "medic" , 0 , 0, 5, "Les chips ou pommes chips, connues aussi sous le néologisme de croustilles au Canada, ", "#66c2ff", "food")
});


var dom_select = {
    "heath" : "#stats > .content > #health > .progress > .progress-container > .progressbar-element",
    "armor" : "#stats > .content > #armor > .progress > .progress-container > .progressbar-element",
    "food" : "#stats > .content > #food > .progress > .progress-container > .progressbar-element",
    "thirst" : "#stats > .content > #thirst > .progress > .progress-container > .progressbar-element",
    "cash" : "#stats > .content > #cash > #data",
    "bank" : "#stats > .content > #bank > #data",
    "side_bottom" : "#side_bottom_window",
    "info_food" : "#side_bottom_window > .content > .info > .ar > .food",
    "info_thirst" : "#side_bottom_window > .content > .info > .ar > .thirst",
    "info_health" : "#side_bottom_window > .content > .info > .ar > .health",
    "info_name" : "#side_bottom_window > .content > .info > .desc > span",
    "info_description" : "#side_bottom_window > .content > .info > .desc > p",
    "info_quantity" : "#side_bottom_window > .content > .action > .quantity > .content > .number",
    "info_quantity_up" : "#side_bottom_window > .content > .action > .quantity > .content > .up",
    "info_quantity_down" : "#side_bottom_window > .content > .action > .quantity > .content > .down",
    "info_weight_lift" : "#inventory > .content > .header > .max_weight"
}



// stats
function SetHealth(new_health)
{
    let healt = document.querySelector(dom_select.heath);
    healt.style.width = new_health + "%";
    return true
}

function SetWeightLift(current_weight, max_weight)
{
    let new_string = format("max weight : {curweight}/{maxweight}",{curweight:current_weight,maxweight: max_weight});
    $(dom_select.info_weight_lift).text(new_string);
    return true
}

function SetArmor(new_armor)
{
    let armor = document.querySelector(dom_select.armor);
    armor.style.width = new_armor + "%";
    return true
}

function SetFood(new_food)
{
    let armor = document.querySelector(dom_select.food);
    armor.style.width = new_food + "%";
    return true
}

function SetThirst(new_thirst)
{
    let armor = document.querySelector(dom_select.thirst);
    armor.style.width = new_thirst + "%";
    return true
}

function SetCash(new_cash)
{
    let cash = document.querySelector(dom_select.cash);
    cash.innerHTML = new_cash
    return true
}

function SetBank(net_account_cash)
{
    let cash_account = document.querySelector(dom_select.bank);
    cash_account.innerHTML = net_account_cash
    return true
}

// inventory
var selected_item
var list_item = [];

function HideSidePanel(){
    $(dom_select.side_bottom).hide();
}

function clearInventory() {
    $('#items').empty(); 
}

function AddItem(id, name, quantity, thumb, type , thirst, food, health, descrip, color_type, icon_type){
    let item = {
        "id" : id,
        "name" : name,
        "quantity" : quantity,
        "thumb" : thumb,
        "type" : type,
        "thirst" : thirst,
        "food" : food,
        "health" : health,
        "descrip" : descrip,
        "color_type" : color_type,
        "icon_type" : icon_type,
    }

    list_item.push(item);


    let object_div = "<div class='object' id="+ id +"></div>"
    let thumb_div = "<div class='thumb'></div>"
    let info_div = "<div class='info'></div>"

    let thumb_element = " <img src='" + thumb + "'>"
    let type_element = "<div class='type'>" + BuildSvg(icon_type, "icon") + "</div>"
    let name_element = "<span class='name'>" + name + "</span>"
    let quantity_element = "<span class='quantity'>x " + quantity + "</span>"

    if($('#' + id).length == 0){
        $('#items').append(object_div); 
     
        $('#' + id).append(thumb_div);  
        $('#' + id).append(info_div);

    
        if ( $('#' + id).text().length == 0 ) {
            $( '#' + id ).children('.thumb').append(thumb_element);  
            $( '#' + id ).children('.info').append(type_element);  
            $( '#' + id ).children('.info').append(name_element);  
            $( '#' + id ).children('.info').append(quantity_element); 
        }
          
    }

    $('#' + id).click(function() {
        $('.object' ).each(function() {
            $( this ).removeClass( "ItemsActive" );
        });

        SelectItem(id)
    });
}

function SelectItem(id) {
    $('#' + id).addClass("ItemsActive")
    $(dom_select.side_bottom).fadeIn();
    let item
    selected_item = id

    $.each( list_item, function( key, value ) {
        if( id == value['id']) {
            item = value
        }
    });

    $(dom_select.side_bottom).show()

    $(dom_select.info_quantity_down).css('cursor', 'default');
    $(dom_select.info_quantity_up).css('cursor', 'pointer');


    $(dom_select.info_quantity_up).mouseenter(function() {
        $(this).addClass("qtihover")
    }).mouseleave(function() {
        $(this).removeClass("qtihover")
    });

    $(dom_select.info_quantity_down).mouseenter(function() {
        $(this).addClass("qtihover")
    }).mouseleave(function() {
        $(this).removeClass("qtihover")
    });

    SetItemInfo(item['name'], item['thirst'], item['food'], item['health'], item['descrip'], item['color_type'])
}

$(dom_select.info_quantity_up).click(function() {
    let item

    $(dom_select.info_quantity_down).css('cursor', 'pointer');


    $.each( list_item, function( key, value ) {
        if( selected_item == value['id']) {
            item = value
        }
    });

    let max = parseInt(item['quantity'])
    let max_dys = parseInt($(dom_select.info_quantity).text())

    let new_val = max_dys + 1;

    if(new_val <= max){
        $(dom_select.info_quantity).text(new_val)
    }

    if(new_val == max){
        $(this).css('cursor', 'default');
    }

});

$(dom_select.info_quantity_down).click(function() {
    let item

    $(dom_select.info_quantity_up).css('cursor', 'pointer');

    $.each( list_item, function( key, value ) {
        if( selected_item == value['id']) {
            item = value
        }
    });

    let max = parseInt(item['quantity'])
    let max_dys = parseInt($(dom_select.info_quantity).text())

    let new_val = max_dys - 1;

    if(new_val <= max && new_val >= 1){
        $(dom_select.info_quantity).text(new_val)
    }else{

    }

    if(new_val == 1){
        $(this).css('cursor', 'default');
    }
});

function SetItemInfo(name, thirst, food, healt, descrip, type_color)
{
    $(dom_select.info_name).text(name)
    $(dom_select.info_name).css("color", type_color)
    console.log(healt)

    $(dom_select.info_thirst).show()
    $(dom_select.info_food).show()
    $(dom_select.info_health).show()

    if(food == 0) {
        $(dom_select.info_food).hide()
    }else{
        $(dom_select.info_food + " > p").text(food)
    }

    if(thirst == 0) {
        $(dom_select.info_thirst).hide()
    }else{
        $(dom_select.info_thirst + " > p").text(thirst)
    }

    if(healt == 0) {
        $(dom_select.info_health).hide()
    }else{
        $(dom_select.info_health + " > p").text(healt)
    }
    $(dom_select.info_description).text(descrip)
    $(dom_select.info_quantity).text(1)
}

// window
$(".survival").click(function() {
    CallEvent("CallCloseSurvival");
});

$("#side_bottom_window > div > div.action > div > div.drop").click(function() {
    if(selected_item != undefined){
        let quantity = $(dom_select.info_quantity).text()
        CallEvent("CallDropItem", selected_item, quantity);
    }
});

$("#side_bottom_window > div > div.info > div.desc > .use").click(function() {
    let quantity = $(dom_select.info_quantity).text()
    if(selected_item != undefined){
        CallEvent("CallUseItem", selected_item);
    }
});
