using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;

public class SessionManager : MonoBehaviour
{
    public static int user_id = -1;
    public static string SERVER = "104.215.189.210";
    // Start is called before the first frame update
    void Start()
    {
        DontDestroyOnLoad(this.gameObject);
    }

    // Update is called once per frame
    void Update()
    {

    }
    public static IEnumerator updatecrazeOnPhonicPoints(int child_id_id, int receive_point)
    {
        Debug.Log("tawag sa api");
        WWWForm form = new WWWForm();
        form.AddField("child_id_id", child_id_id.ToString());
        form.AddField("receive_point", receive_point.ToString());
        UnityWebRequest uwr = UnityWebRequest.Post($"http://{SERVER}/api/updatecrazeOnPhonicPoints/", form);
        yield return uwr.SendWebRequest();

        if (uwr.isNetworkError)
        {
            Debug.Log("Error While Sending: " + uwr.error);
        }
        else
        {
            Debug.Log("Received: " + uwr.downloadHandler.text);
        }
    }
    public static IEnumerator updatewordKitPoints(int child_id_id, int receive_point)
    {
        Debug.Log("tawag sa api");
        WWWForm form = new WWWForm();
        form.AddField("child_id_id", child_id_id.ToString());
        form.AddField("receive_point", receive_point.ToString());
        UnityWebRequest uwr = UnityWebRequest.Post($"http://{SERVER}/api/updatewordKitPoints/", form);
        yield return uwr.SendWebRequest();

        if (uwr.isNetworkError)
        {
            Debug.Log("Error While Sending: " + uwr.error);
        }
        else
        {
            Debug.Log("Received: " + uwr.downloadHandler.text);
        }
    }
    public static IEnumerator updatealphaHopperPoints(int child_id_id, int receive_point)
    {
        Debug.Log("tawag sa api");
        WWWForm form = new WWWForm();
        form.AddField("child_id_id", child_id_id.ToString());
        form.AddField("receive_point", receive_point.ToString());
        UnityWebRequest uwr = UnityWebRequest.Post($"http://{SERVER}/api/updatealphaHopperPoints/", form);
        yield return uwr.SendWebRequest();

        if (uwr.isNetworkError)
        {
            Debug.Log("Error While Sending: " + uwr.error);
        }
        else
        {
            Debug.Log("Received: " + uwr.downloadHandler.text);
        }
    }
    public static IEnumerator updatemazeCrazePoints(int child_id_id, int receive_point)
    {
        Debug.Log("tawag sa api");
        WWWForm form = new WWWForm();
        form.AddField("child_id_id", child_id_id.ToString());
        form.AddField("receive_point", receive_point.ToString());
        UnityWebRequest uwr = UnityWebRequest.Post($"http://{SERVER}/api/updatemazeCrazePoints/", form);
        yield return uwr.SendWebRequest();

        if (uwr.isNetworkError)
        {
            Debug.Log("Error While Sending: " + uwr.error);
        }
        else
        {
            Debug.Log("Received: " + uwr.downloadHandler.text);
        }
    }
    public static IEnumerator updatereadingSpreePoints(int child_id_id, int receive_point)
    {
        Debug.Log("tawag sa api");
        WWWForm form = new WWWForm();
        form.AddField("child_id_id", child_id_id.ToString());
        form.AddField("receive_point", receive_point.ToString());
        UnityWebRequest uwr = UnityWebRequest.Post($"http://{SERVER}/api/updatereadingSpreePoints/", form);
        yield return uwr.SendWebRequest();

        if (uwr.isNetworkError)
        {
            Debug.Log("Error While Sending: " + uwr.error);
        }
        else
        {
            Debug.Log("Received: " + uwr.downloadHandler.text);
        }
    }
}
