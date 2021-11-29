using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Death_ : MonoBehaviour
{
    public GameObject deadExplosion;


    Rigidbody2D rb;
    float dirX;

    [SerializeField]
    float moveSpeed = 2f;

    void Start()
    {

    }

    void Update()
    {
        dirX = Input.GetAxisRaw("Vertical") * moveSpeed * Time.deltaTime;
        transform.position = new Vector2(transform.position.x + dirX, transform.position.y);
    }

    void dead()
    {
        Instantiate(deadExplosion, transform.position, Quaternion.identity);
        Destroy(gameObject);
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.tag == "Spike")
        {
            Time.timeScale = 1F;
            dead();
        }
    }
}
