using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;


public class Jump_ : MonoBehaviour
{
    /// <summary>
    /// speed of the jump animation. Jump animation works also with Time.timeScale so you would not need to change this
    /// </summary>
    public float animationSpeed = 1;

    /// <summary>
    /// maxheight reached in units at the jump. Took as reference the highest point between the origin and the destiny of the jump. It can't be negative
    /// </summary>
    public float jumpHeight = 1;

    private Vector2 diff, origin, destiny, speed;

    /// true if guy gameObjecct is jumping
    private bool move;


    /// time spent since last jump
    private float time;

   
    private bool IsPointerOverUIObject()
    {
        PointerEventData eventDataCurrentPosition = new PointerEventData(EventSystem.current);
        eventDataCurrentPosition.position = new Vector2(Input.mousePosition.x, Input.mousePosition.y);
        List<RaycastResult> results = new List<RaycastResult>();
        EventSystem.current.RaycastAll(eventDataCurrentPosition, results);
        return results.Count > 0;
    }

    private void Update()
    {
        //when we click at the screen we setUp the jump. Just change the condition from Input.GetMouseButton(0) to the statement you wish
        if (Input.GetMouseButtonDown(0))
        {
            time = 0;
            move = true;

            origin = transform.position;
            destiny = Camera.main.ScreenToWorldPoint(Input.mousePosition);
            diff = destiny - origin;

            CalculateSpeed();
        }

        //movement
        if (move)
        {
            time += Time.deltaTime * animationSpeed;
            transform.position = new Vector2(origin.x + speed.x * time, origin.y + speed.y * time + 0.5f * Physics2D.gravity.y * Mathf.Pow(time, 2));

            //when we pass the objective point
            if ((diff.x > 0 && transform.position.x >= destiny.x) || (diff.x < 0 && transform.position.x <= destiny.x))
            {
                //reset time and stop moving
                time = 0;
                move = false;
                //set position to the exact position
                transform.position = destiny;
            }
        }
    }

    /// <summary>
    /// set speed var with the value the gameObject shall have in order to reach the destiny point
    /// </summary>
    private void CalculateSpeed()
    {
        float maxHeight = diff.y > 0 ? diff.y + jumpHeight : jumpHeight;

        var speedY = Mathf.Sqrt(-2 * Physics2D.gravity.y * maxHeight);
        speed = new Vector2
        (
            diff.x * Physics2D.gravity.y / (-speedY - Mathf.Sqrt(Mathf.Abs(Mathf.Pow(speedY, 2) + 2 * Physics2D.gravity.y * diff.y))),
            speedY
        );
    }

   
}