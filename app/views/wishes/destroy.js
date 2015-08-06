/* Destroy the product  from the wish list */
$("#wish_details").html("<%= escape_javascript(render("cart")) %>");

/* Reset the wish form */
$("#destroy_wish")[0].reset();


