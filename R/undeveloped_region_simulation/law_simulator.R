## ----input data--------------------------------------------------------------------------------
select_property <- function(property_cat) {
  property_cat <- as.character(property_cat)
  property_cat <- paste0('0', property_cat)
  
  
  if (property_cat %in% limit_lu$cat) {
    boundary <- limit_lu |>
      filter(cat == property_cat)
  }else{
      message('ID not found')
    return(NULL)
  }
}
    
    

#NEED TO DEVELOP TEST FOR SF OBJECT
#if(class(p)[1] != "sf") p <- sf::st_as_sf(p)


## ----------------------------------------------------------------------------------------------
# property_dimensions <- function(paddock_area = 999000,
#                                  hedgerow_width = 50,
#                                  width_paddock = 1,
#                                  height_paddock = 1,
#                                  tol = 0.01,
#                                  new_dim = NULL,
#                                  max_iter = 100) {
#   # Dimensions
#   max_pad <- paddock_area
#   max_hedgerow <- hedgerow_width
#   pad_hedge <- max_pad + max_hedgerow
# 
#   # Aspect Ratio (from square to rectangle)
#   ratio_x <- c(1, 2, 3, 4)
#   ratio_y <- c(1, 2, 3, 4)
#   aspect_ratio <- width_paddock / height_paddock
# 
#   if (width_paddock %in% ratio_x & height_paddock %in% ratio_y) {
#     if (!is.null(new_dim)) {
#       # User-specified cell size
#       x <- new_dim[1]
#       y <- new_dim[2]
#     } else {
#       # Initial cell size based on aspect ratio and total area
#       y <- sqrt(pad_hedge / (ratio_x[width_paddock] / ratio_y[height_paddock]))
#       x <- sqrt(pad_hedge * (ratio_x[width_paddock] / ratio_y[height_paddock]))
#     }
# 
#     # Initialize variables for iteration
#     x_y <- tibble(x, y)
#     iter <- 1
#     error <- Inf
# 
#     while (error > tol & iter <= max_iter) {
#       # Generate the grid and buffer
#       fc <- st_sfc(st_polygon(list(rbind(c(0,0), c(1,0), c(1,1), c(0,1),c(0,0))))) |> st_set_crs('EPSG:32721')
#       mini_grid <- st_make_grid(fc, cellsize = c(x, y), n = c(1, 2)) |> st_cast(to = 'MULTILINESTRING')
#       mini_buff <- st_buffer(mini_grid, dist = 50, singleSide = TRUE) |> st_as_sf() |> st_union()
# 
#       # Generate the paddock and calculate its area
#       mini_regrid <- st_make_grid(fc, cellsize = c(x_y[[1]], x_y[[2]]), n = c(1, 1))
#       mini_pad <- st_difference(mini_regrid, mini_buff)
#       area_pad <- st_area(mini_pad) |> drop_units()
# 
#       # Calculate the error and update the cell size
#       error <- abs(area_pad - paddock_area)
#       if (area_pad < paddock_area) {
#         # Increase the cell size
#         factor <- (paddock_area - area_pad) / area_pad
#         y_new <- y * sqrt(1 + factor / aspect_ratio)
#         x_new <- x * sqrt(1 + factor * aspect_ratio)
#       } else {
#         # Decrease the cell size
#         factor <- (area_pad - paddock_area) / area_pad
#         y_new <- y / sqrt(1 + factor / aspect_ratio)
#         x_new <- x / sqrt(1 + factor * aspect_ratio)
#       }
# 
#       # Update the cell size and the iteration counter
#       x_y <- tibble(x_new, y_new)
#       x <- x_new
#       y <- y_new
#       iter <- iter + 1
#     }
# 
#     if (iter > max_iter) {
#       warning("Maximum number of iterations reached without convergence")
#     }
# 
#     # Return the final cell size and the paddock area
#   result <- list(dimensions = x_y, area = area_pad)
# 
#   if (!is.null(new_dim)) {
#     # If new_dim argument is provided, update the dimensions
#     result$dimensions <- new_dim
#   } else if (!is.null(tol)) {
#     # If tol argument is provided, update the cell size
#     dim_new <- result$dimensions * (1 + tol)
#     result$dimensions <- dim_new
#   }
# 
#   }
#     return(as.data.frame(result))
# 
# }



## ----------------------------------------------------------------------------------------------

# 
#  property_dimensions <- function(paddock_area = 999000,
#                                  hedgerow_width = 50,
#                                  width_paddock = 1,
#                                  height_paddock = 1,
#                                  tolerance = 0.1,
#                                  max_iter = 100) {
#   # Dimensions
#   max_pad <- paddock_area
#   max_hedgerow <- hedgerow_width
#   pad_hedge <- max_pad + max_hedgerow
# 
#   # Aspect Ratio (from square to rectangle)
#   ratio_x <- c(1, 2, 3, 4)
#   ratio_y <- c(1, 2, 3, 4)
#   aspect_ratio <- width_paddock / height_paddock
# 
#   if (width_paddock %in% ratio_x & height_paddock %in% ratio_y) {
#     y <- sqrt(pad_hedge / (ratio_x[width_paddock] / ratio_y[height_paddock]))
#     x <- sqrt(pad_hedge * (ratio_x[width_paddock] / ratio_y[height_paddock]))
# 
#     # Initialize variables for iteration
#     x_y <- tibble(x, y)
#     iter <- 1
#     error <- Inf
# 
#     while (error > tolerance & iter <= max_iter) {
#       # Generate the grid and buffer
#       fc <- st_sfc(st_polygon(list(rbind(c(0,0), c(1,0), c(1,1), c(0,1),c(0,0))))) |> st_set_crs('EPSG:32721')
#       mini_grid <- st_make_grid(fc, cellsize = c(x, y), n = c(1, 2)) |> st_cast(to = 'MULTILINESTRING')
#       mini_buff <- st_buffer(mini_grid, dist = 50, singleSide = TRUE) |> st_as_sf() |> st_union()
# 
#       # Generate the paddock and calculate its area
#       mini_regrid <- st_make_grid(fc, cellsize = c(x_y[[1]], x_y[[2]]), n = c(1, 1))
#       mini_pad <- st_difference(mini_regrid, mini_buff)
#       area_pad <- st_area(mini_pad) |> drop_units()
# 
#       # Calculate the error and update the cell size
#       error <- abs(area_pad - paddock_area)
#       if (area_pad < paddock_area) {
#         # Increase the cell size
#         factor <- (paddock_area - area_pad) / area_pad
#         y_new <- y * sqrt(1 + factor / aspect_ratio)
#         x_new <- x * sqrt(1 + factor * aspect_ratio)
#       } else {
#         # Decrease the cell size
#         factor <- (area_pad - paddock_area) / area_pad
#         y_new <- y / sqrt(1 + factor / aspect_ratio)
#         x_new <- x / sqrt(1 + factor * aspect_ratio)
#       }
# 
#       # Update the cell size and the iteration counter
#       x_y <- tibble(x_new, y_new)
#       x <- x_new
#       y <- y_new
#       iter <- iter + 1
#     }
# 
#     if (iter > max_iter) {
#       warning("Maximum number of iterations reached without convergence")
#     }
# 
#     # Return the final cell size and the paddock area
#     result <- list(dimensions = x_y, area = area_pad)
#   } else {
#     result <- list(dimensions = NULL, area = NULL)
#     warning("INVALID RATIO OF WIDTH TO HEIGHT")
#   }
#   return(as.data.frame(result))
# }
# 



## ----------------------------------------------------------------------------------------------
# 1222580.005 width_paddock = 3,height_paddock = 1
#1222999.9

# 
property_dimensions <- function(desired_area = 999000 ,
                        hedgerow_width = 100,
                        width_paddock = 1,
                        height_paddock = 1) {
    width_paddock <- as.integer(width_paddock)
    height_paddock <- as.integer(height_paddock)
  #Dimensions

 

  # Aspect Ratio (from square to rectangle)
  ratio_x <- c(1,2,3,4)
  ratio_y <- c(1,2,3,4)

  if(width_paddock %in% ratio_x & height_paddock %in% ratio_y){
  y <- sqrt(desired_area / (ratio_x[width_paddock]/ratio_y[height_paddock])) + (hedgerow_width)

  x <- sqrt(desired_area * (ratio_x[width_paddock]/ratio_y[height_paddock])) + (hedgerow_width)

  x_y <- tibble(x, y)

  return(x_y)
  }else{
    print('INVALID RATIO OF WIDTH TO HEIGHT')
  }

}



## ----------------------------------------------------------------------------------------------
grid_rotate <-
  function(boundary_property = property_boundary,
           x_y = pad_hedg_dim) {
    coords_df <- st_coordinates(property_boundary)
    
    number_col <- ncol(coords_df)
    x1 <- coords_df[1, 1]
    y1 <- coords_df[1, 2]
    x2 <- coords_df[2, 1]
    y2 <- coords_df[2, 2]
    
    
    
    # calcualte the angle in radians and the trasformate to degrees
    angle_r <- atan2(y2 - y1, x2 - x1)
    #angle_r <- atan2(height, base)
    
    angle <- 90 + ((angle_r * (180 / pi)) * -1)
    angle
    
    
    
    inpoly <- boundary_property |>
      st_geometry()
    rotang = angle 
    
    
    
    rot = function(a)
      matrix(c(cos(a), sin(a), -sin(a), cos(a)), 2, 2)
    
    
    
    tran = function(geo, ang, center)
      (geo - center) * rot(ang * pi / 180) + center
    
    center <- st_centroid(st_union(boundary_property))
    
    
    grd <-
      sf::st_make_grid(tran(inpoly, -rotang, center),
                       cellsize = c(x_y[[1]], x_y[[2]]),
                       n = 100)
    
    
    
    grd_rot <- tran(grd, rotang, center) |> st_set_crs("EPSG:32721")
    
    
    
    
    
    test_rot <-  st_intersection(grd_rot, boundary_property)
    return(test_rot)
  }



## ----------------------------------------------------------------------------------------------

riparian_cut <- function(rip_corr = riparian_corridor, prop_gr = property_grid) {
  # Using riparian corridor cut the property fragments
  if (is.null(rip_corr)) {
    return(prop_gr)
  } else{
    prop_frag_rip <-
      st_difference(prop_gr, rip_corr)
    return(prop_frag_rip)
  }
}


## ----------------------------------------------------------------------------------------------
reserve <- function(grid = property_fragment) {
  grid_boundary_sf <- st_as_sf(grid)
  
  cell_areas <- grid_boundary_sf |>
    mutate(cell_area = st_area(grid_boundary_sf))
  
  n <- 1
  repeat {
    forest <-  cell_areas %>%
      arrange(cell_area) %>%
      head(n)
    area_check <-
      sum((st_area(forest) / sum(st_area(cell_areas))) * 100 )
    
    if (area_check >= set_units(25,1) & area_check <= set_units(28,1)) {
      break
    }
    n <- n + 1
  }
  forest <- st_union(forest)
  return(forest)
}


## ----------------------------------------------------------------------------------------------
no_reserve_area <- function(grid_property = property_fragment,
                            fr_union = forest_reserve){
  #remaining property without forest reserve
  grd_sf <- st_as_sf(grid_property)
  fr_sf <- st_as_sf(fr_union)
  remaining_property <- st_difference(grd_sf, fr_sf)
  

}


## ----------------------------------------------------------------------------------------------
riparian_buffer <-
  function(boundary_property = property_boundary,
           hydrology = hydro,
           buffer = 100) {
    # check if there's is river crossing property
    
    if (lengths(st_crosses(boundary_property, hydrology)) > 0) {
      riv_test <- st_intersection(hydrology, property_boundary) |>
        st_make_valid() |>
        st_transform("EPSG:32721")
      
      # buffer around river
      riparian <- st_buffer(riv_test, dist = buffer, endCapStyle = 'FLAT')
      return(riparian)
      
    } else{
      return(NULL)
    }
  }


## ----------------------------------------------------------------------------------------------
make_hedges <- function(fragment = property_remaining) {
  # Make remaining property without forest into a a solid polygon and regrid. Regridding creates individual cells with geometry that can be buffered for hedgerows
  #fragment_valid <- st_union(fragment) |> st_make_valid() |> st_cast(to = 'POLYGON')
  prop_combine <- st_union(fragment, is_coverage = TRUE)
  regrid <- grid_rotate(prop_combine) |> st_cast(to= 'MULTILINESTRING') |> st_make_valid()#|> st_set_crs(value = 'EPSG:32721')
  
  hedge <- st_buffer(regrid, dist = 50)  |>  st_as_sf() |> st_make_valid()  |>  st_union() 
  
  
  
  return(hedge)
}  


## ----------------------------------------------------------------------------------------------

make_paddocks <- function(frag = property_remaining, rows = hedgerows) {
    # pad will give the combined paddocks as one polygon to so st_area only returns one value
    #pad <- st_difference(prop_combine, hedgerow)
      #fragment_valid <- st_union(frag) |> st_make_valid() |> st_cast(to = 'POLYGON')
    prop_combine <- st_union(frag, is_coverage = TRUE)
    regrid2 <- grid_rotate(prop_combine)
    pad <-  st_difference(regrid2, rows)
    return(pad)
    
# To get individual paddocks regrid area that has removed forest and take difference with hedgerows
    
  }


## ----------------------------------------------------------------------------------------------
st_erase = function(x, y) st_difference(x, st_union(st_combine(y)))


## ----------------------------------------------------------------------------------------------
# if(is.null(riparian_corridor) ) {
#     final_paddock <- paddocks
#     final_hedgrow <- hedgerows
# }else{
#   final_paddock <- st_difference(paddocks, riparian_corridor)
# 
#   fr_union <- st_union(forest_reserve)
#   final_reserve <- st_difference(fr_union,riparian_corridor)
# 
# 
# # property_fragments <- st_difference(grid,fr_union)
#   final_hedgrow <- st_difference(hedgerows, riparian_corridor)
# 
#   riparian_area <- (st_area(riparian_corridor) / st_area(property_boundary)) * 100
#       }




# 
# tmap_arrange(tm_shape(final_hedgrow) + 
#   tm_polygons(col = 'green'),
# 
# tm_shape(final_paddock) + 
#   tm_polygons(col = 'beige'),
# 
# tm_shape(final_reserve) + 
#   tm_polygons(col = 'forestgreen'),
# 
# tm_shape(riparian_corridor) +
#   tm_polygons('dodgerblue'),
# 
# tm_shape(forest_reserve) +
#   tm_polygons(col = 'forestgreen')+
# tm_shape(riparian_corridor) +
#   tm_polygons(col = 'dodgerblue')+
# tm_shape(hedgerows) +
#   tm_polygons(col = 'green')+
# tm_shape(final_paddock) +
#   tm_polygons('beige')
# )


## ----------------------------------------------------------------------------------------------
# 
# tm_shape(property_boundary) +
#   tm_sf()
# tm_shape(forest_reserve) +
#   tm_polygons(col = 'forestgreen')
# tm_shape(final_hedgerow) +
#   tm_polygons(col = 'green')
# tm_shape(paddocks) +
#   tm_polygons('beige')
#   tm_shape(riparian_corridor) +
#   tm_polygons(col = 'lightcyan')
# 
# 
# tm_shape(property_boundary) +
#   tm_sf('red')+
# tm_shape(forest_reserve) +
#   tm_polygons(col = 'forestgreen')+
# tm_shape(final_hedgerow) +
#   tm_polygons(col = 'green')+
# tm_shape(paddocks) +
#   tm_polygons('beige')+
#   tm_shape(riparian_corridor) +
#   tm_polygons(col = 'lightcyan')




