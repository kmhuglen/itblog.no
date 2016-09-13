---
layout: post
title: 'Sømløs brukeropplevelse mot skybaserte- og tradisjonelle applikasjoner?'
published: true
author: kmhuglen
comments: true
date: 2016-06-15 05:06:00
tags:
    - Azure AD
    - Firstpoint
    - Intune
    - Windows 10
    - Windows Store
categories:
    - it-pro
permalink: /5946
---
**Er Windows 10 verktøyet som tar BYOD fra hype til hyllevare?**

Bring-Your-Own-Device har blitt snakket om lenge, men er mindre utbredd enn man skulle tro ut fra markedsføringen. Dette kan nå begynne å endre seg med de mulighetene som Windows 10 gir, samt at verktøyene for å kontrollere og konfigurere enhetene har blitt mer modne. I dette innlegget vil jeg prøve å gi et kort innblikk i nye muligheter: Hvordan de kan gi en god brukeropplevelse og hvordan IT-avdelingen kan redusere manuelle tidkrevende prosesser.

**Azure AD Join**
  
Denne integrerte funksjonen i Windows 10 gir gode brukeropplevelser og benyttes for å koble maskinen mot Azure AD. Azure AD kan enten være en forlengelse av bedriftens interne Active Directory eller et helt eget separat AD levert fra Azure. Når man kobler en maskin mot Azure AD kan man automatisk registrere den i et verktøy for å utføre administrasjon og kontroll av mobile enheter (MDM eller Mobile Device Management). Kundene kan velge mellom ulike aktører, for eksempel Citrix XenMobile eller Vmware AirWatch. Microsoft leverer dette også selv via Microsoft Intune. Microsoft Intune blir brukt som eksempel her.

**Fler-faktor autentisering og selvbetjening**
  
Med lisenser for Azure AD Premium eller Enterprise Mobility Suite (EMS) følger tilgang på en rekke andre funksjoner som fler-faktor autentisering (MFA), selvbetjening av passord reset/change/unlock, selvbetjent gruppe styring samt analyse av pålogginger for å oppdage og hindre uvedkommende. Alle leveres som skytjenester og krever ikke oppsett av intern infrastruktur.

**Mobile Device Management**
  
Når en maskin er registrert i Intune kan en sende ut innstillinger, retningslinjer (Policy) til enheten, tilgjengeliggjøre eller utføre installasjon av programvare og lignende. Eksempel på retningslinjer kan være at maskinen skal være kryptert med BitLocker, ha oppdatert antivirus, krav til passord, m.m.

Her er en kort video av hvordan en sluttbruker selv setter opp en ny Windows 10 maskin på 5 minutter ferdig konfigurert. It-avdelingen kan være trygg på at deres krav til sikkerhet er oppfylt og sluttbrukeren får en sømløs pålogging (Single-Sign-On (SSO)) til alle sine tjenester.

<iframe src="{{site.url}}/videos/2016-06-15-somlos-brukeropplevelse-mot-skybaserte--og-tradisjonelle-applikasjoner.Video1.mp4"></iframe>

Video 1:23 min: Oppsett av en ny Windows 10 PC via Azure AD Join. Førstegangspålogging, avsluttes med at bruker må godta bedriftens policy.

**Tradisjonelle applikasjoner**
  
I dag skal it-avdelingen ikke bare støtte både tradisjonelle applikasjoner, enten installert direkte på maskinen eller publisert ut via terminal server, men også tilby nye skybaserte applikasjoner fra sitt eget datasenter eller kjøpt som en SaaS-tjeneste. Hybride tilnærminger blir trolig normen i god tid fremover

Ny funksjonalitet fra både Citrix og VMware løser denne utfordringen ved å publisere applikasjoner fra bedriftens interne terminal og VDI tjenester og gi SSO hele veien.


  https://itblog.blob.core.windows.net/public/BLOG-Video2-Cut.mp4



  
Video 0:58: Innlogging på en Windows 10, Single-Sign-On mot intern Citrix portal og oppstart av en applikasjon uten flere spørsmål om brukernavn og passord.

**Den virkelig gode brukeropplevelsen.**

Her har jeg vist et eksempel på hvordan en sluttbruker selv kan sette opp en ny Windows 10 maskin, og oppnå en god brukeropplevelse. Det fine er at en trenger ikke ta i bruk alle funksjonene. Hver av komponentene kan settes opp separat. 

**Windows Store for Business**
  



  https://itblog.blob.core.windows.net/public/BLOG-Video3-Cut.mp4
 Video 0:20: Windows Store for Business med tvungen installasjon av utvalgte applikasjoner via Intune

Ønsker du å høre mer rundt Windows 10, Azure AD, Bring-You-Own eller Single-Sign-On og hvordan du kan utnytte deg av mulighetene i ditt miljø? Vi har flere konsulenter som jobber med dette området &#8211; ta kontakt med Knut Magne, Ole Idar, Magnar, Frode eller Christopher, eller via Bjørn Uddal i Oslo