; 51

; 思路 1

; 生成单一交通灯：半径 20，实体：红，黄，绿，灰
; 生成 3 种状态交通灯：红色状态（红灰灰），黄色状态（灰黄灰），绿色状态（灰灰绿）
; 每种状态交通灯，由 3 个单一交通灯，自上至下排列。
; number -> light
(define RADIUS 20)
(define RED_LIGHT (circle RADIUS "solid" "red" ))
(define YELLOW_LIGHT (circle RADIUS "solid" "yellow" ))
(define GREEN_LIGHT (circle RADIUS "solid" "green" ))
(define GRAY_LIGHT (circle RADIUS "solid" "gray" ))

(define traffic_red_light
    (above RED_LIGHT GRAY_LIGHT GRAY_LIGHT ))

(define traffic_yellow_light
    (above GRAY_LIGHT YELLOW_LIGHT GRAY_LIGHT ))
    
(define traffic_green_light
    (above GRAY_LIGHT GRAY_LIGHT GREEN_LIGHT))

; 依据当前状态 state，产生下一个状态
; TrafficLight -> TrafficLight
(define (next_traffic_light state) 
  (cond
    [(string=? "red" state) "yellow"]
    [(string=? "yellow" state) "green"]
    [(string=? "green" state) "red"]))

(check-expect (next_traffic_light"red") "yellow")
(check-expect (next_traffic_light"yellow") "green") 
(check-expect (next_traffic_light"green") "red")   

; 根据下一个状态，展示对应的交通灯
; state -> image 
(define (traffic_light state)
    (cond
        [(string=? state "red") traffic_red_light]            ; 下一状态是红灯，则显示红灯
        [(string=? state "yellow") traffic_yellow_light]  ; 下一状态是黄灯，则显示黄灯
        [(string=? state "green") traffic_green_light]))  ; 下一状态是绿灯，则显示绿灯

; 定义主函数，读取初始状态，读取变化频率，生成对应的图像
; state ,rate -> image 
(define (main state rate)
    (big-bang state
        (on-tick next_traffic_light rate)
        (to-draw traffic_light)))

(main "red" 2)

; 思路 2  (Ai 给出)

; 定义三种颜色的圆形交通灯
(define red-light (circle 50 "solid" "red"))
(define green-light (circle 50 "solid" "green"))
(define yellow-light (circle 50 "solid" "yellow"))

; 根据时间t的值渲染交通灯的颜色
(define (render-state t)
  (cond
    [(= (modulo t 3) 0) red-light]
    [(= (modulo t 3) 1) green-light]
    [(= (modulo t 3) 2) yellow-light]))

; 每次时钟周期，t 增加 1
(define (next-state t)
  (+ t 1))

; 定义运行的最大时间 (在这个例子中为 15 个周期)
(define max-duration 15)

; 当达到最大时长时停止
(define (stop? t)
  (>= t max-duration))

; 使用big-bang来启动动画
(big-bang 0                  ; 初始状态 t = 0
  (on-tick next-state 1) ; 每1秒钟增加1
  (to-draw render-state)
  (stop-when stop?))
